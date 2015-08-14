From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Aug 2015 16:21:51 -0500
Subject: [PATCH v5] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <1439287646.9747.212.camel@citrix.com>
References: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
 <1439287646.9747.212.camel@citrix.com>
Message-ID: <CAL_JsqKv2aOEM-U7JNZnaHomA6HFBSFhSLZ-zhp7c20s6gQBaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+arm-soc

On Tue, Aug 11, 2015 at 5:07 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
> On Mon, 2015-08-03 at 17:06 +0100, Ian Campbell wrote:
>> Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
>> LogicTile Express 20MG") added a new dts file to arch/arm64 which
>> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
>> .dtsi supplied by arch/arm.
>>
>> Unfortunately this causes some issues for the split device tree
>> repository[0], since things get moved around there. In that context
>> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
>> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>
> Hi Grant,
>
> Do you think there is any chance of getting this into 4.2-rc$NEXT or shall
> we wait until 4.3? I'm assuming this should go via the DT tree, but maybe
> it should go via an ARM tree?

I was assuming this would go thru the arm-soc tree which is why I
acked it. It is getting a bit late for 4.2 at this point, but I guess
the standalone tree remains broken for these platforms until this is
done. Probably not such a big deal in grand scheme of things.

Rob
