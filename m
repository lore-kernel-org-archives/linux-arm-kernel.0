From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 26 Aug 2010 10:05:39 +0300
Subject: gs_start_io() and gs_close()
In-Reply-To: <loom.20100826T032027-25@post.gmane.org>
References: <loom.20100826T032027-25@post.gmane.org>
Message-ID: <4C761243.6000606@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 08/26/10 04:21, Jim Sung wrote:
> I'm debugging a problem with the USB gadget serial on the Marvell PXA168

CC'ed LAKML

> platform, which led to the following observations:
>
> - The way gs_start_io() is implemented, each time it is invoked,
>   port->read_pool and port->write_pool will grow by QUEUE_SIZE, which
>   seems wrong.
>
>   For now, I just added a list_empty() check in gs_start_io() on the two
>   lists.
>
> - "struct gs_port" does not appear to have provision to notify the USB
>   device controller to release any resource (particularly for rx) in
>   gs_close().
>
>   To fix the problem, I have a hard coded call into the USB device
>   controller right now, but that is ugly.
>
> The particular kernel I'm working with is 2.6.28, but I took a look at
> 2.6.35-rc6, and I don't see any change in these areas.
>
> Jim
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.
