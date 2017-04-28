From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 13:41:58 +0200
Subject: [PATCH 2/2] dt-bindings: pcie: Add documentation for Mediatek PCIe
In-Reply-To: <1493347596.29314.55.camel@mtkswgap22>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a1vgi9VBZfRNq0dDKzmfe8FkHQtgz6fEXW9fyUnBHtaQQ@mail.gmail.com>
 <1493194205.27023.80.camel@mtkswgap22>
 <CAK8P3a0vD8s_3R+jS=JdUXX3X05SkCk-mipMA6UxWYQZe6vLUQ@mail.gmail.com>
 <1493347596.29314.55.camel@mtkswgap22>
Message-ID: <CAK8P3a0WGwukWj8V-S2c13S3futkxBhiMfRTa=0QWaDG7qREVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 4:46 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Thu, 2017-04-27 at 21:06 +0200, Arnd Bergmann wrote:
>> On Wed, Apr 26, 2017 at 10:10 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> > On Tue, 2017-04-25 at 14:18 +0200, Arnd Bergmann wrote:
>> >> On Sun, Apr 23, 2017 at 10:19 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> Are any of the registers the same at all, e.g. for MSI handling?
>
> No, It doesn't support MSI. All I can do is using the registers that designer provide
> to me. The others are inviable for software. So I treat it as different hardware.
> Furthermore, we hope that we can put all mediatek drivers together
> regardless of in-house IP or lincense IP
>
> We have no particular IP name but just use chip name to call it. So I
> will temporarily use "mediatek,gen2v1-pcie" in patch v1.

I think using the chip name as in the first version of your patch name is
better then, in particular since the 'gen2v1' would not be an actual version
number but just say which variant got merged into mainline first.

A related question would be on how general we want the binding to be.
Your binding text starts out by describing that there are three root ports
and what their capabilities are.

If you think there might be other (existing or future) chips that use the
same binding and driver, then being a little more abstract could help
in the long run.

       Arnd
