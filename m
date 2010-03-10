From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 10 Mar 2010 07:07:49 +0100
Subject: [PATCH 02/11] ST SPEAr: Added basic header files for SPEAr3xx
	machine family
In-Reply-To: <4B9735B2.1030108@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<63386a3d1003091242i5e8786e4n1fe0d83b97d51e3b@mail.gmail.com>
	<4B9735B2.1030108@st.com>
Message-ID: <63386a3d1003092207yd7a5a6dqf0aeb03ba67e602a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/10 Viresh KUMAR <viresh.kumar@st.com>:
> On 3/10/2010 2:12 AM, Linus Walleij wrote:

>> If you want to keep this file anyway, move it from mach-spear3xx/include/mach
>> to just mach-spear3xx and include like this: #include "misc_regs.h" and
>> thus avoid the entire drivers/* tree (etc) from being able to #include
>> <mach/misc_regs.h>
>> because surely any machine-specific special driver using these very
>> machine-specific
>> registers will be in mach-spear3xx/ anyway.
>
> Surely, any standard driver will not use them. Actually we have kept clock
> framework code common to different machines in plat-spear.
> And here we need to use misc_regs.h, for this reason i kept it in
> mach/include/mach.

Okay so the plat-spear code use <mach/misc_regs.h> that is different
between different machines? Then it's correct of course, sorry for going
astray, please keep it there then.

Yours,
Linus Walleij
