From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Fri, 5 Dec 2014 14:14:35 +0200
Subject: [RFC PATCH 4/5] ARM: enable linking against eventfd and irqchip
In-Reply-To: <20141129112933.GF13623@macair>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212706.10605.50148.stgit@i3820>
 <20141129112933.GF13623@macair>
Message-ID: <CADDJ2=Ptc3yC7AQdcr0yx7R2uf0pa+6zDdJhGZKczJ8VxJ1Gng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 29, 2014 at 1:29 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Inidicate KVM in the subject please.
>
> On Mon, Nov 24, 2014 at 11:27:06PM +0200, Nikolay Nikolaev wrote:
>> This enables compilation of the eventfd feature on ARM.
>
> does this enable anything else than the ioeventfd stuff so that
> everything is in place to do this safely now?
Inspecting the eventfd.c I see that there is the IRQFD code
conditionally compiled when CONFIG_HAVE_KVM_IRQFD is defined.
 I think this is enabled for arm/arm64 in Eric's IRQFD patcheries, so
we should be safe now.

regards,
Nikolay Nikolaev

>
> -Christoffer
