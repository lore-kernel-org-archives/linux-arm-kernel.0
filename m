From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 25 Jun 2012 15:57:28 +0530
Subject: [PATCHv9 3/8] I2C: OMAP: use devm_* functions
In-Reply-To: <20120625095152.GE6468@arwen.pp.htv.fi>
References: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
 <1340273329-8319-4-git-send-email-shubhrajyoti@ti.com>
 <20120625095152.GE6468@arwen.pp.htv.fi>
Message-ID: <CAM=Q2ctMte0ukkbkry=LofR_GaQdWJZy5kt+4ni3ysjF8gH1=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 3:21 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Jun 21, 2012 at 03:38:44PM +0530, Shubhrajyoti D wrote:
>> The various devm_* functions allocate memory that is released when a driver
>> detaches. This patch uses devm_kzalloc, devm_request_and_ioremap for data
>> that is allocated in the probe function of a platform device and is only
>> freed in the remove function.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> this looks a lot like:
> http://marc.info/?l=linux-omap&m=133969143407572&w=2
>
> I wonder why wasn't that one used instead ?

Indeed will drop this one from the series.
In fact, missed the irq part.
