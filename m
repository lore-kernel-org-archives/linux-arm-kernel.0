From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Apr 2015 21:47:52 +0200
Subject: [RFC PATCH 2/2] tee: add OP-TEE driver
In-Reply-To: <3960750D-EAE4-4FA0-9E15-89F9CE39257E@javigon.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <4984990.7rV4p0zMYU@wuerfel>
 <3960750D-EAE4-4FA0-9E15-89F9CE39257E@javigon.com>
Message-ID: <7401865.1Pb83TJP0q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 April 2015 13:17:20 Javier Gonz?lez wrote:
> 
> Only providing user space support would defeat one of the main purposes
> of the driver. We could better organize the patches and divide them into user
> space support and in-kernel support if that is what you mean. In the end
> the interfaces are orthogonal, even though the functionality should be very
> similar.

Splitting up the patches to separate the user interface from the in-kernel
interface is certainly a good idea, but aside from that, I also agree with
Greg on this point: if you want to establish an in-kernel interface, don't
add any dead code at the beginning, but add it together with the users
of that interface.

	Arnd
