From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 3 Jul 2015 08:52:10 +0200
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <E959C4978C3B6342920538CF579893F0025E6C89@SHSMSX104.ccr.corp.intel.com>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025E6C89@SHSMSX104.ccr.corp.intel.com>
Message-ID: <5596311A.3010703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2015 04:43, Wu, Feng wrote:
> 
> struct irq_bypass_consumer {
>        struct list_head node;
>        void *token;
> +      unsigned irq;	/*got from producer when registered*/
>        void (*add_producer)(struct irq_bypass_producer *,
>                             struct irq_bypass_consumer *);
>        void (*del_producer)(struct irq_bypass_producer *,
>                             struct irq_bypass_consumer *);
> +      void (*update)(struct irq_bypass_consumer *);
> };
> 
> 'update' is used to update the IRTE, while irq is initialized when
> registered, which is used to find the right IRTE.

Feel free to add "update" in your PI patches.  I am not sure if "irq"
belongs here or in the containing struct.  You can play with both and
submit the version that looks better to you.

Paolo
