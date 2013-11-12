From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Nov 2013 09:29:11 -0600
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <52814AFB.3070600@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
Message-ID: <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 3:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2013 01:29 PM, Jason Cooper wrote:
>> Consumers of the Linux kernel's build products are beginning to hardcode
>> the filenames of the dtbs generated.  Since the dtb filenames are
>> currently the dts filename s/dts/dtb/, this prevents the kernel
>> community from renaming dts files as needed.
>
> My take is that the DTB filenames are part of the ABI, and therefore the
> DTS filenames are also part of the ABI. Why would we want to rename them?

I agree with the ABI part, but for long term I think compatible
strings are a better choice for the ABI than filenames. A link
provides for a way to transition.

Whether a platform can tolerate a filename change is really up to the
platform maintainer like other ABI changes.

Rob
