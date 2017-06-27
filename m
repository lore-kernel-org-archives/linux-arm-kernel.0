From: jacobchen110@gmail.com (Jacob Chen)
Date: Tue, 27 Jun 2017 23:45:14 +0800
Subject: [PATCH 1/5] [media] rockchip/rga: v4l2 m2m support
In-Reply-To: <CAAFQd5BHAiTq9f4nvwFiy5DzZ0Jep9d4K0saAkoxzaK86a8GJg@mail.gmail.com>
References: <1498488673-27900-1-git-send-email-jacob-chen@iotwrt.com>
 <CAAFQd5BHAiTq9f4nvwFiy5DzZ0Jep9d4K0saAkoxzaK86a8GJg@mail.gmail.com>
Message-ID: <CAFLEztSVySd5iZFg7Oz3yGoR8zb2ik_qtBvVvmYfgX_zja_7RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,
Yeah, the comments are wrong, i will correct it

>> +        */
>> +       pages = (unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
>
> This is rather unfortunate and you should expect failures here on
> actively used systems with uptime longer than few hours. Changing this
> to dma_alloc_coherent() and enabling CMA _might_ give you a bit better
> success rate, but...
>
> Normally, this kind of (scatter-gather capable) hardware would allow
> some kind of linking of separate pages, e.g. last entry in the page
> would point to the next page, or something like that. Doesn't this RGA
> block have something similar?
>

Thx for pointing it out ! : )

I looked RGA drvier used in rockchip android and i find it use
kmalloc, so i think it might support separate pages.
I will test it.


> Best regards,
> Tomasz
