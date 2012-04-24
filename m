From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 14:00:43 +0530
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424082652.GQ24211@n2100.arm.linux.org.uk>
References: <20120424070426.GA24089@lunn.ch> <4F9650B3.9030406@st.com>
 <20120424072653.GB24089@lunn.ch>
 <20120424074202.GO24211@n2100.arm.linux.org.uk> <4F965D1C.2010203@st.com>
 <20120424082652.GQ24211@n2100.arm.linux.org.uk>
Message-ID: <4F9664B3.6040104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 1:56 PM, Russell King - ARM Linux wrote:
> Think about this case: if you don't have the means to control the clock
> inputs to a device (for example, you don't support the clk API on your
> CPU arch) then for the device to be functional, it must be supplied with
> all its necessary clocks.  Therefore, the clock is already enabled.  It
> makes sense for the clk API to stub-out to be completely transparent and
> non-error inducing to the driver.
> 
> The problem comes with clk_get_rate().  I'd suggest merely returning zero
> for that in this case.  If the clock rate is really required by a driver,
> then the clk API would need to be enabled.

Ok. Will do as suggested. Will include the patches i dropped earlier, where
i removed macros for clk_*().

-- 
viresh
