From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Jan 2014 21:15:33 +0100
Subject: [PATCH 1/4] ARM: STi: add stid127 soc support
In-Reply-To: <52EB96BB.6070800@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <201401301939.08302.arnd@arndb.de> <52EB96BB.6070800@st.com>
Message-ID: <201401312115.33731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014, srinivas kandagatla wrote:

> > Sorry if I missed the initial review, but can you explain
> > why this is needed to start with?
>
> On ST SoCs the default value for L2 AUX_CTRL register is 0x0, so we  set
> the way-size explicit here.

Unfortunately, we keep going back and forth on the L2 cache controller
setup between "it should work automatically" and "we don't want to
have configuration data in DT", where my personal opinion is that
the first one is more important here.

Now, there are a couple of properties that are defined in
Documentation/devicetree/bindings/arm/l2cc.txt to let some of the
things get set up automatically already. Can you check which bits
are missing there, if any? Are they better described as "configuration"
or "hardware" settings?

	Arnd
