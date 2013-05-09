From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 09 May 2013 15:47:36 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <20130509144055.GF3200@sirena.org.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com> <518A8E6C.6070907@st.com>
 <20130509095143.GB7478@sirena.org.uk> <518B8F49.5020902@st.com>
 <20130509132600.GA3200@sirena.org.uk> <518BABF0.7040201@st.com>
 <20130509144055.GF3200@sirena.org.uk>
Message-ID: <518BB708.7040505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 15:40, Mark Brown wrote:
> So what exactly is the driver doing then?  If the register maps look
> nothing like each other then what's the common functionality the driver
> is providing?
What I meant here is that, sysconf registers are reassigned per SOC, so
the sysconf register definitions change per SOC, not the register map of
the device itself.

The register map of the device itself still looks the same, however few
bits of the IP are wired up to the global sysconf registers, which is
what keeps changing, w.r.t sysconf number or bits of the sysconf itself.
