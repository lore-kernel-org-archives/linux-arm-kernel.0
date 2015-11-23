From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 16:37:50 +0000
Subject: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
In-Reply-To: <20151123163359.GC768@1wt.eu>
References: <5868782.RxZY0W5S4d@wuerfel>
 <20151123163359.GC768@1wt.eu>
Message-ID: <20151123163750.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 05:33:59PM +0100, Willy Tarreau wrote:
> I think you could do better by simply calling panic("BUG!") instead as
> BUG() does. It will avoid the printk() call and pushing the file/line
> number onto the stack. It will also probably not inflate the rodata this
> way.

Does that not depend on the architectures BUG() implementation?  If an
architecture implements it as a signalling illegal instruction and a
lookup table, changing it to be a panic() would probably be more code.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
