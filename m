From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 24 Mar 2014 10:33:18 +0100
Subject: Disabling gcc inline operation
In-Reply-To: <CAK7N6vrgnNdFvo8as+DrhXurxP+SexN9gi3WFrX_SCO9i2Ybyw@mail.gmail.com>
References: <CAK7N6vrgnNdFvo8as+DrhXurxP+SexN9gi3WFrX_SCO9i2Ybyw@mail.gmail.com>
Message-ID: <532FFBDE.7030407@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/14 23:31, anish singh wrote:
> Many a time i have got a crash and it is difficult
> to find out the exact function which crashed
> because the crash stack doesn't show the "real"
> function because gcc inlines many functions when
> ever it desires or when it optimizes for speed.
>
> So i don't want gcc to inline any function instead
> just call the function so that i can see the crash
> stack of each function called. I just want to do
> this for debugging. Please let me know how can
> i do that?
>
> What switch command to pass to gcc in the make
> of linux kernel?

You tried to look at gcc.gnu.org, right? Your best options are -O0 
and/or -Og for debugging purposes.

Regards,
Arend

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
