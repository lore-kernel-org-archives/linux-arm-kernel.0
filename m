From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 21:33:47 +0100
Subject: [PATCH v2 01/12] mm/memblock: add MEMBLOCK_NOMAP attribute to
 memblock memory table
In-Reply-To: <20151116194914.GK8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-2-git-send-email-ard.biesheuvel@linaro.org>
 <20151116185859.GF8644@n2100.arm.linux.org.uk>
 <CAKv+Gu-COD0eSWqaTfV_QgCDEiBg5Af8FDVx+TMiYuVkqgTrvw@mail.gmail.com>
 <20151116194914.GK8644@n2100.arm.linux.org.uk>
Message-ID: <35E90006-1E43-4483-8B18-7123E12E68FF@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 16 nov. 2015, at 20:49, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
>> On Mon, Nov 16, 2015 at 08:09:38PM +0100, Ard Biesheuvel wrote:
>> The main difference is that memblock_is_memory() still returns true
>> for the region. This is useful in some cases, e.g., to decide which
>> attributes to use when mapping.
> 
> Ok, so we'd need to switch to using memblock_is_map_memory() instead
> for pfn_valid() then.

Indeed, as is implemented by 10/12

> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
