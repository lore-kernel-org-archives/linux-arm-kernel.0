From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Nov 2016 17:15:24 +0100
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <13493313.OkuDZEY5WO@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej> <13493313.OkuDZEY5WO@wuerfel>
Message-ID: <36115245.zHVRydMfpb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 8, 2016 5:09:59 PM CET Arnd Bergmann wrote:
> 
> I don't see a better alternative. I earlier suggested having these
> out of line so we don't grow the object code too much when it is
> enabled.
> 

On second look, I see that they are all done out of line, I would
just move around the BUILD_EXTIO macro to the file that uses it
and remove and open-code the DECLARE_EXTIO() as that makes it easier
to grep.

	Arnd
