From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Nov 2015 17:52:58 +0100
Subject: [PATCH 1/4] ARM: dt: mvebu: ix4-300d: remove whole flash partition
In-Reply-To: <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20151128165258.GG32356@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 12:14:05PM +0100, Sebastian Hesselbarth wrote:
> Current NAND node has an additional flash partition for the whole
> flash overlapping with real partitions. Remove this partition as
> the whole flash is already represented by the NAND device itself.

If i remember correctly, we discussed this when the contribution was
made. I think the stock firmware might use this for applying updates.
Maybe Benoit can comment?

If so, removing this will break compatibility with stock firmware. Do
we want to do that? There are a few other mvebu dts files with a
partition spanning the whole flash. Should we remove them as well?

	      Andrew
