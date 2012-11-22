From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 16:08:00 -0800
Subject: [PATCH v5 05/10] pinctrl: single: support pinconf generic
In-Reply-To: <CAN1soZxUr4uO3fheKpRU_oc-GjjYfo2ZY5YZ0hRgwB2ph+b-qw@mail.gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-6-git-send-email-haojian.zhuang@gmail.com>
 <20121117004313.GN6801@atomide.com>
 <CAN1soZxUr4uO3fheKpRU_oc-GjjYfo2ZY5YZ0hRgwB2ph+b-qw@mail.gmail.com>
Message-ID: <20121122000800.GC5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121117 20:53]:
> On Sat, Nov 17, 2012 at 8:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> I agree that returning data directly would be easy for the usage in
> device driver. Let's define it as "data >> shift".
> Is it OK?

Yes returning data >> shift makes sense to me from consumer driver
point of view, so I guess then it's just what I too suggested:

data = (data >> arg.bits.shift) & arg.bits.mask;
*config = data;

Or did I miss something? 

Regards,

Tony
