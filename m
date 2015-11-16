From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 19:49:15 +0000
Subject: [PATCH v2 01/12] mm/memblock: add MEMBLOCK_NOMAP attribute to
 memblock memory table
In-Reply-To: <CAKv+Gu-COD0eSWqaTfV_QgCDEiBg5Af8FDVx+TMiYuVkqgTrvw@mail.gmail.com>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-2-git-send-email-ard.biesheuvel@linaro.org>
 <20151116185859.GF8644@n2100.arm.linux.org.uk>
 <CAKv+Gu-COD0eSWqaTfV_QgCDEiBg5Af8FDVx+TMiYuVkqgTrvw@mail.gmail.com>
Message-ID: <20151116194914.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 08:09:38PM +0100, Ard Biesheuvel wrote:
> The main difference is that memblock_is_memory() still returns true
> for the region. This is useful in some cases, e.g., to decide which
> attributes to use when mapping.

Ok, so we'd need to switch to using memblock_is_map_memory() instead
for pfn_valid() then.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
