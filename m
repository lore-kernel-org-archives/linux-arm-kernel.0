From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Feb 2013 12:49:22 -0500 (EST)
Subject: [PATCH 1/3] SPEAr13xx_defconfig: Enable Memory split 2G/2G needed
In-Reply-To: <CAKohpokPhHtuDDBPUYp9YPOrEnaaKxthjiAemq74qfour_3aYQ@mail.gmail.com>
References: <cover.1360317993.git.vijay.kumar@st.com>
 <6cebd9755011670ecaeec7930b3fa7ed0f16b3b6.1360317993.git.vijay.kumar@st.com>
 <CAKohpokPhHtuDDBPUYp9YPOrEnaaKxthjiAemq74qfour_3aYQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1302081243400.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Feb 2013, Viresh Kumar wrote:

> Hi Vijay,
> 
> By mistake you have added an ST internal list in cc, fixed it now.
> 
> Subject should be:
> 
> ARM: SPEAr13xx: Enable 2G/2G Memory split in defconfig
> 
> On 8 February 2013 16:16, Vijay Kumar Mishra <vijay.kumar@st.com> wrote:
> > Memory split 2G/2G is enabled as needed for SPEAr1310 RevC board to boot.
> > Before enabling this option the boot was hanging at uncompressing linux.

I disagree.  The subject could have been "put our head in the sand and 
paper over bugs".

Please don't do that.  There is no reason for any machine not to boot 
way past "Uncompressing Linux" with the default split.  The likely 
reason it works with the 2G:2G split is because in that case the virtual 
and physical RAM addresses in the kernel are the same, and therefore 
missing p2v or v2p conversions are invisible.


Nicolas
