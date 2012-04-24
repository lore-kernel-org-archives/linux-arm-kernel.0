From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 24 Apr 2012 16:04:22 +0400
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <4F9650B3.9030406@st.com>
References: <20120424070426.GA24089@lunn.ch> <4F9650B3.9030406@st.com>
Message-ID: <4F9696C6.1080404@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-04-2012 11:05, Viresh Kumar wrote:

>> I don't think this change is correct. With the old semantics, it was:

> Sorry. :(

>> If we have CLK support, we expect there to be a clock for sata_mv, and
>> if there is no such clock, output a notice message, something is
>> probably wrong, i expected there to be a clock.

>> The new semantics are:

>> We expect there to be a clock for sata_mv, and if there is no such
>> clock, output a notice message, something is probably wrong, i
>> expected there to be a clock.

>> We are going to see this notice message much more, when it is not
>> expected.

> So, the only problem is this message?
> How do you suggest to tackle this now. Have #ifdef,#endif around this print?

    When there's no CONFIG_HAVE_CLK, if clk_get() returns NULL, not error, 
there'll be no message.

WBR, Sergei
