From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 14:54:16 +0100
Subject: [RFC PATCH 09/11] DT: regulator: Helper to extract regulator
	node based on supply name
In-Reply-To: <1316085727-15023-10-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<1316085727-15023-8-git-send-email-rnayak@ti.com>
	<1316085727-15023-9-git-send-email-rnayak@ti.com>
	<1316085727-15023-10-git-send-email-rnayak@ti.com>
Message-ID: <20110915135416.GN7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:52:05PM +0530, Rajendra Nayak wrote:

> 		regulator = <&regulator1>,<&regulator2>;
> 		regulator-names = "supply1","supply2";
> 	};

This syntax is really painful - we're relying on keeping two arrays in
sync which isn't good for legibility or robustness.  I'd expect
something like having a property with the supply name referencing the
regulator node concerned like:

	dbvdd = <&regulator1>;
	dcvdd = <&regulator2>;

or something.  Keeping the two arrays separate doesn't seem great.
