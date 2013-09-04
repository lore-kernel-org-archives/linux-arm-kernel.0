From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Sep 2013 10:59:09 -0700
Subject: [PATCH v4 5/5] clk: dt: binding for basic gate clock
In-Reply-To: <CAD6h2NSr0cM_SWqniC30pYm0mCeziBOzVg-46-814qPMxUwDCQ@mail.gmail.com>
References: <1377150793-27864-1-git-send-email-mturquette@linaro.org>
 <1377150793-27864-6-git-send-email-mturquette@linaro.org>
 <CAD6h2NRBq8hD8J5+P4NBZJZsPo4QAebgGaxmAn5TL0c2Cc5ULQ@mail.gmail.com>
 <5220FB48.7080607@wwwdotorg.org>
 <CAD6h2NSr0cM_SWqniC30pYm0mCeziBOzVg-46-814qPMxUwDCQ@mail.gmail.com>
Message-ID: <20130904175909.GB31541@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130903 20:11]:
> 
> We can see that it'll try to find static mapping. What's the static mapping?
> If we define iotable in machine driver, we have the static mapping, just like
> debug_ll. If we parse everything from DTS file, it'll always get a new virtual
> address from vm area. So it always create a new page mapping even for one
> register.

I may not follow you here.. But it seems that you've missing something with
the static mapping: It's found based on the physical address. So if you
create static mappings for your SoC with iotable_init(), those mappings
will be available everywhere including drivers when you do ioremap().

Regards,

Tony
