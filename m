From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 16 Apr 2014 23:28:42 +0400
Subject: [PATCH v4 21/21] misc: support for I-8024 in LP-8x4x
In-Reply-To: <20140416193949.47f4ea68@alan.etchedpixels.co.uk>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-15-git-send-email-ynvich@gmail.com>
 <20140416193949.47f4ea68@alan.etchedpixels.co.uk>
Message-ID: <9eb6a7ac-e8c0-4c05-8f8a-e047d2614cba@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:
>On Wed, 16 Apr 2014 21:17:26 +0400
>Sergei Ianovich <ynvich@gmail.com> wrote:
>
>> Status of I-8042 4 analog output channels can be managed via
>> sysfs.
>
>Surely this is an iio interface and should follow the same API as
>everyone else ?

Thanks for the feedback. It's the first response to this particular driver ever.

I've looked around the tree and found tons of industrial io device drivers in different places: drivers/iio, drivers/misc, drivers/staging/comedi to name a few.

I've closely examined a dozen or two of drivers, but of them was close enough for I-8024 in terms of speed. Its channel takes 0.1 us to set up from kernel. Real user space programs can setup all for channels in 1 us with interface provided by this patch. That's said I don't have data on time that it takes for output to stabilize at the desired levels.

I've chosen drivers/misc as a location that looked to provide the shortest path for my driver to land. The driver needs support for the bus, and here it can be in one driver.

It would be great to have some more detailed input on this issue.
