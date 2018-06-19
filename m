From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 20 Jun 2018 02:43:14 +0300
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
In-Reply-To: <20180619225145.GA23389@kroah.com>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
Message-ID: <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 1:51 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
>> For debugging purposes it may be useful to know what are the devices whose
>> probe function was deferred. Add a debugfs entry showing that information.
>>
>>   $ cat /sys/kernel/debug/deferred_devices
>>   48070000.i2c:twl at 48:bci
>>   musb-hdrc.0.auto
>>   omapdrm.0


> And what is the use of this file?  What can you do with this
> information?  Who is going to use it?  Don't we have other deferred
> probe debugging somewhere else?

Indeed.

Javier, have you tried to add 'initcall_debug' to a kernel command
line followed by 'dyndbg="file drivers/base/dd.c +p"'?

-- 
With Best Regards,
Andy Shevchenko
