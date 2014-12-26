From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 09:27:07 -0600
Subject: [PATCH] USB: gadget: udc: atmel: fix possible oops when
 unloading module
In-Reply-To: <549A138D.50204@atmel.com>
References: <1419240374-12179-1-git-send-email-songjun.wu@atmel.com>
 <20141223162419.GB9147@saruman> <549A138D.50204@atmel.com>
Message-ID: <20141226152707.GG17430@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 24, 2014 at 09:14:53AM +0800, Wu, Songjun wrote:
> 
> ? 12/24/2014 00:24, Felipe Balbi ??:
> >On Mon, Dec 22, 2014 at 05:26:14PM +0800, Songjun Wu wrote:
> >>When unloading the module, the urb request will be dequeued
> >>and the completion routine will be excuted.
> >>If no urb packet, the urb request will not be added to the endpoint queue
> >>and the completion routine pointer in urb request is NULL.
> >>Accessing to the NULL function pointer will cause the oops issue.
> >>Add the code to check the urb request is in the endpoint queue or not.
> >>If the urb request is not in the endpoint queue, a negative error code
> >>will be returned.
> >
> >have you triggered the NULL pointer oops ? Care to add it to the commit
> >log.
> 
> Executing the 'insmod g_hid.ko', then executing the 'rmmod g_hid.ko', the
> NULL pointer oops will be triggered.

what about all my other queries below and what about adding the oops
dump to commit log ?

> >Also, which commit is this fixing ? Does this need to be backported ?
> >When was the bug introduced ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/b3c6d350/attachment.sig>
