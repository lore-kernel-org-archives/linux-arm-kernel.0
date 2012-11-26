From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Nov 2012 10:19:33 +0000
Subject: [question] some question about the residue
In-Reply-To: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
References: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
Message-ID: <20121126101933.GA19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 02:43:17PM +0800, Elen Song wrote:
> Hi All:
> 
> 	I got a question about the residue in struct dma_tx_state:
> 
> 	I wonder what residue means, is it the current descriptor residue or
> 
> 	the total dma buffer residue?

It's the number of bytes remaining to be transferred on the descriptor
identified by the cookie.  If that transfer has not been started, it
will be the total number of bytes in that transfer.  If it has been
completed, it will be zero.  If it is in progress, it will be the number
of bytes to be transferred before the transfer identified by that cookie
is marked as complete.
