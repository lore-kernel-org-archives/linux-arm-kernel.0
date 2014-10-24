From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 24 Oct 2014 08:53:40 -0700
Subject: [PATCH v2 08/47] kernel: Move pm_power_off to common code
In-Reply-To: <544A2017.7020804@imgtec.com>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
 <544A2017.7020804@imgtec.com>
Message-ID: <20141024155340.GA22426@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 10:47:03AM +0100, James Hogan wrote:
> Hi Guenter,
> 
> On 21/10/14 05:12, Guenter Roeck wrote:
> > pm_power_off is defined for all architectures. Move it to common code.
> > 
> > Have all architectures call do_kernel_power_off instead of pm_power_off.
> > Some architectures point pm_power_off to machine_power_off. For those,
> > call do_kernel_power_off from machine_power_off instead.
> > 
> > Acked-by: David Vrabel <david.vrabel@citrix.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> > Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Acked-by: Richard Weinberger <richard@nod.at>
> > Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
> 
> For metag:
> Acked-by: James Hogan <james.hogan@imgtec.com>
> 
Thanks!

Guenter
