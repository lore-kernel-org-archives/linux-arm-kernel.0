From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 13:29:56 +0530
Subject: [PATCH 2/2] dma/amba-pl08x: add support for the Nomadik variant
In-Reply-To: <CACRpkdaz9g7cRc1rAMHUzRbLcrYtB-kPCB6bFEMYZxxmWfLNSg@mail.gmail.com>
References: <1334004816-20219-1-git-send-email-linus.walleij@linaro.org>
 <4F83AC55.3070900@st.com>
 <CACRpkdaz9g7cRc1rAMHUzRbLcrYtB-kPCB6bFEMYZxxmWfLNSg@mail.gmail.com>
Message-ID: <4F8539FC.4030503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2012 1:29 PM, Linus Walleij wrote:
>>> >> +                             ch->locked = true;
>>> >> +                     } else
>>> >> +                             ch->locked = false;
>>> >> +             }
>>> >> +
>> >
>> > Memory for ch is allocated with kmalloc and so its default value is garbage.
>> > So we must set locked to false in else part here.
> Hm maybe better to kzalloc() the channel structs?
> 

Then, you can remove code which makes its field zero explicitly, as it is already
zero.

-- 
viresh
