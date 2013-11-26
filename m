From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Nov 2013 00:01:53 +0000
Subject: clk: clk_round_rate() should return 0, not negative numbers,
 upon error
In-Reply-To: <alpine.DEB.2.02.1311251553080.23090@tamien>
References: <alpine.DEB.2.02.1311251553080.23090@tamien>
Message-ID: <20131126000153.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:55:33PM -0800, Paul Walmsley wrote:
>
> Update the documentation for clk_round_rate() to state that it should
> return 0 rather than a negative error code when it encounters an
> error.  This describes how the common clock framework currently works;
> howeever, some clock code does not yet align to this.
>
> This change is to prepare for returning unsigned values from
> clk_round_rate().

You really ought to document why this is being changed here, to help
sell the change to parties who are not aware of the background.
Otherwise, it just looks like a gratuitous API change.
