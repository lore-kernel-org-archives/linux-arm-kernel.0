From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Oct 2015 13:54:05 -0500
Subject: [PATCH v2 05/13] arm64: enable building of all dtbs
In-Reply-To: <CAMuHMdVDdNOp5z_TjwBVUDqZuZ0NZNAu7cJ6stsZqqXOBsY_tw@mail.gmail.com>
References: <1444326827-3565-1-git-send-email-robh@kernel.org>
 <1444326827-3565-6-git-send-email-robh@kernel.org>
 <CAMuHMdVDdNOp5z_TjwBVUDqZuZ0NZNAu7cJ6stsZqqXOBsY_tw@mail.gmail.com>
Message-ID: <CAL_JsqLrRc==SPbs6a1irkGA0rFYdJfUg-wWV8yq7MjGtRC58g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 1:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 8, 2015 at 7:53 PM, Rob Herring <robh@kernel.org> wrote:
>> Enable building all dtb files when CONFIG_OF_ALL_DTBS is enabled. The dtbs
>> are not really dependent on a platform being enabled or any other kernel
>> config, so for testing coverage it is convenient to build all of the dtbs.
>> This builds all dts files in the tree, not just targets listed. This
>> is simpler for arm64 which has a bunch of sub-dirs.
>
> This doesn't look simpler than the arm(32) version?

I discussed this with Olof in the last version. In the ARM version, I
could have done just one line "dtb-$(CONFIG_OF_ALL_DTBS) += $(dtb-)"
to add all the disabled dtbs. On arm64, I would have to do that for
each sub-dir Makefile as well as make sure any new sub-dirs have this
line. In the end, I also prefer to build everything in the tree and
not rely on the dtbs to be explicitly listed.

Rob
