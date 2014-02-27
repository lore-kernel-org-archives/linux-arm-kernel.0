From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 27 Feb 2014 12:55:58 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CACxGe6tjuytsYAn6Hadf0AK+REzHgRydgbHPafL8+Sdtd_tMUA@mail.gmail.com>
References: <20140226183454.GA14639@cbox>
 <CACxGe6tjuytsYAn6Hadf0AK+REzHgRydgbHPafL8+Sdtd_tMUA@mail.gmail.com>
Message-ID: <CAFEAcA8DrF6TfAe-bM8NoW+y-cNomg8zxkPB1oe6LY_JG-wsSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2014 22:35, Grant Likely <grant.likely@linaro.org> wrote:
> On 26 Feb 2014 18:35, "Christoffer Dall" <christoffer.dall@linaro.org>
> wrote:
>>   Serial console:  The platform should provide a console,
>>   based on an emulated pl011, a virtio-console, or a Xen PV console.
>
> For portable disk image, can Xen PV be dropped from the list? pl011 is part
> of SBSA, and virtio is getting standardised, but Xen PV is implementation
> specific.

The underlying question here is to what extent we want to
force VMs to provide a single implementation of something
and to what extent we want to force guests to cope with "any
choice from some small set". Personally I don't think it's
realistic to ask the Xen folk to drop their long-standing
PV bus implementation, and so the right answer is roughly
what we have here, ie "guest kernels need to cope with both
situations". Otherwise Xen is going to go its own way anyway,
and you just end up either (a) ruling out Xen as a platform
for running portable disk images or (b) having an unofficial
requirement to handle Xen PV anyway if you want an actually
portable image, which I would assume distros do.

thanks
-- PMM
