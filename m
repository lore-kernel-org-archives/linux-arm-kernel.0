From: pratyush.anand@st.com (Pratyush Anand)
Date: Fri, 7 Feb 2014 12:13:12 +0530
Subject: [PATCH V4 6/8] phy: st-miphy-40lp: Add SPEAr1310 and SPEAr1340
 PCIe phy support
In-Reply-To: <20140207035429.GB2414@pratyush-vbox>
References: <cover.1391661589.git.pratyush.anand@st.com>
 <dca9c501de8386003142b463469c3d267a049eeb.1391661589.git.pratyush.anand@st.com>
 <201402061637.05414.arnd@arndb.de>
 <20140207035429.GB2414@pratyush-vbox>
Message-ID: <20140207064312.GC2414@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Feb 07, 2014 at 11:54:30AM +0800, Pratyush ANAND wrote:
> Hi Arnd,
> 
> On Thu, Feb 06, 2014 at 11:37:05PM +0800, Arnd Bergmann wrote:
> > On Thursday 06 February 2014, Pratyush Anand wrote:
> > 

[...]

> > I think it's better to make this code table-driven. Rather than checking
> > 'of_device_is_compatible()', it's much easier to add a .data field to
> > the of_device_id array that describes the PHY. You can use .data to
> > point to a structure containing per-device function pointers or
> > (better) values and offsets to be used.

values and offset would be good as long as we do not need to write on
conditional read status. In our case its OK, as we do not need to
write conditionally. But, would it be a good idea to go that way?

Regards
Pratyush

> 
> Sounds a better idea. will reduce code size a lot. Thanks.
> 
> Regards
> Pratyush
> 
> > 
> > 	Arnd
