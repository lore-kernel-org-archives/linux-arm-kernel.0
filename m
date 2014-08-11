From: mohun106@gmail.com (Radha Mohan)
Date: Sun, 10 Aug 2014 20:01:11 -0700
Subject: [PATCH V2] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <1407538940-9167-1-git-send-email-fkan@apm.com>
References: <1407538940-9167-1-git-send-email-fkan@apm.com>
Message-ID: <CAC8NTUXb1JmHwMLjmJtEKXjb+xYtuO4qKnSqMRWwACs35P8_HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,


> +
> +.Lcpy_not_short:
> +       /*
> +        * We don't much care about the alignment of DST, but we want SRC
> +        * to be 128-bit (16 byte) aligned so that we don't cross cache line
> +        * boundaries on both loads and stores.
> +        */

Could you please tell why is destination alignment not an issue? Is
this a generic implementation that you are referring to or specific to
your platform?

> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
