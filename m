From: rajeev-dlh.kumar@st.com (rajeev)
Date: Wed, 1 Sep 2010 11:11:57 +0530
Subject: [PATCH 21/74] ST SPEAr : Added keyboard support
In-Reply-To: <4C7DE35F.9080103@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
	<20100830164825.GA28186@core.coreip.homeip.net>
	<4C7DE35F.9080103@st.com>
Message-ID: <4C7DE7A5.5030805@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2010 10:53 AM, rajeev wrote:
>>> +struct spear_kbd {
>>> >> +     struct input_dev *input;
>>> >> +     void __iomem *io_base;          /* Keyboard Base Address */
>>> >> +     struct clk *clk;
>>> >> +     int *keymap;
>> > 
>> > You need a copy of keymap here so that userspace can modify it safely
>> > via EVIOCSKEYCODE.
>> > 
> We have one copy of struct spear_kbd per device structure. I think it
> will be fine if we change this structure only. And so don't need to copy
> another structure in driver.
> 

Sorry!! I wanted to say "keymap array" not "struct spear_kbd" in above explanation.

rajeev.
