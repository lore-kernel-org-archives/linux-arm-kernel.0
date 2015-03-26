From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Mar 2015 07:23:07 +0100
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <20150325141409.GD26903@localhost>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150325141409.GD26903@localhost>
Message-ID: <CAKv+Gu_RRCLGfHiZ35pHCNHp_=Sx1063dzAhpxWkn2kP0waQfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2015 at 15:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 23, 2015 at 04:36:56PM +0100, Ard Biesheuvel wrote:
>> This aligns PHYS_OFFSET down to an alignment that allows system
>> RAM to be mapped using the largest blocks available, i.e., 1 GB
>> blocks on 4 KB pages or 512 MB blocks on 64 KB pages.
>
> Does this assume that the platform RAM starts at such block aligned
> addresses? If not, is the unaligned range ignored?
>

No, it doesn't. The unaligned range is not mapped by the early code
(it only maps from the start of image)
Later on, it just maps whatever is in the DT nodes.
