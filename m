From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 May 2016 13:30:10 +0900
Subject: [PATCH v3] gpio: UniPhier: add driver for UniPhier GPIO controller
In-Reply-To: <CAK7LNAQH+Ge61+MJo2rLmjCBJRnYviT3LyCo0nrOPRQL+RtK2g@mail.gmail.com>
References: <1436841787-7734-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYaAMw5U3pctf96j0QpY2Qf+e=LX740F0okCmVU6pXkhA@mail.gmail.com>
 <CAK7LNAQ+_ynWT944fPZsHCzMBLtfNu5AnppzaOxNgPSBTvj_tw@mail.gmail.com>
 <CACRpkdZK41P-1JQsL6RiywqFEUj6=g5xJMKy86wDdp6BxLJNzQ@mail.gmail.com>
 <CAK7LNASd9z99RBmUgLVEM1WuLNSzGFM8qzrHwDf58tgGDy2SAw@mail.gmail.com>
 <CACRpkdbBfidn_otxzSV-8HMv2AuD-htUbcRHZ8n9CHAUO=TB9w@mail.gmail.com>
 <CAK7LNAQH+Ge61+MJo2rLmjCBJRnYviT3LyCo0nrOPRQL+RtK2g@mail.gmail.com>
Message-ID: <CAK7LNAQcfrvuG6fD+gN2Ojq4wzCSNa=qpr5kh2QSFJZMCA2UaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2015-07-16 16:48 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Linus,

>
> OK, I will do it in v4.


I has been away from my GPIO driver upstreaming
for a long time for some reason.

I sent v3 ten months ago.
http://patchwork.ozlabs.org/patch/494860/


In the meantime, there have been various updates
in the GPIO frame-work.

So, I'd like to know the recommended driver coding style
based on 4.7-rc1.


Diving into the git-log so far, I came up the following list:

[1] The "dev" member of gpiochip was renamed to "parent"

[2] The most recommended register function is now
    devm_gpiochip_add_data()

[3] Pass the driver private data to the
    3rd argument of devm_gpiochip_add_data().

[4] Do not use container_of() to covert
    from gpiochip to driver private data.
    Instead, gpiochip_get_data() should be used.

    (I used of_mm_gpio_chip in v3,
     but I needed to use container_of() to
     convert from gpiochip to of_mm_gpio_chip.
     I am wondering if you are happy with it or not.)

[5] gpiochip.owner is being deprecated.
    So, platform drivers need not set
     "gpiochip.owner =  THIS_MODULE".


Correct?
Is there anything else missing?

Any advice is appreciated.


-- 
Best Regards
Masahiro Yamada
