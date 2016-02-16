From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 16 Feb 2016 20:27:18 +0100
Subject: [PATCH v5 13/15] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
In-Reply-To: <1455637767-31561-14-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-14-git-send-email-james.morse@arm.com>
Message-ID: <2881465.GhJSKR2Hdf@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 16, 2016 03:49:25 PM James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

This is fine by me.

Please feel free to add my ACK to it if that helps.

Thanks,
Rafael
