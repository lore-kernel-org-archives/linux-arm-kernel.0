From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 12 Aug 2011 04:05:05 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <CAKnu2MptC8HWCNo6W+X9rawn6MCwAe3DB3B5UcHD1tCD9tA2cg@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
	<CAKnu2Mo=9wusKrc7DeL9fk-fq3pY1D3WKHXYmo+b9w5GbyzegA@mail.gmail.com>
	<CABb+yY0G_OeVgQs4ySVMQBcBh2q=nUhj+U+=tZG751WT9qRYuA@mail.gmail.com>
	<CAKnu2MptC8HWCNo6W+X9rawn6MCwAe3DB3B5UcHD1tCD9tA2cg@mail.gmail.com>
Message-ID: <1313102105.1603.35.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-11 at 16:48 +0200, Linus Walleij wrote:
> 2011/8/11 Jassi Brar <jassisinghbrar@gmail.com>:
> 
> > Do you have any reason for using device pointer and strings, other
> > than just "because clock and regulator use them" ??
> 
> Basically no.
> 
> But I think these frameworks are very workable and proven
> to work in practice. So I like them.
> 
> When setting up the platform the coder would to be aware
> that there are totally orthogonal concepts, which IMO
> makes things complicated.
> 
> >>> Do you propose to implement a string parser in the core ?!
> >>
> >> Yes, the clock and regulator framework already does that.
> >> But it is only used when you cannot pass in a struct device *
> >> directly, like from device tree.
> >
> > Dude, I have utter disrespect for using strings in a case such as
> > expressing requirements.
> 
> It's mainly a strcmp(), and it's only comparing to the
> well-established namespace that all devices have anyway,
> due to the way the device model is done.
> 
> Basically when binding clocks or regulators it's:
> 
> struct device *dev;
> strcmp(map_string, dev_name(dev));
> 
> By this time struct device exist of course, since
> it's the device driver calling to get its clock/regulator.
> 
> dev_name() comes from <linux/device.h> and basically
> takes the kobject name or an optional initilizer name
> for the device. So the names are pretty static, you don't
> need to parse them, just compare.
> 
> > I have already explained how we can easily and in a _better_ way
> > do without them (again see my last reply to Vindo's setup).
> > Tell me 1 reason why using strings, in this case, would be better ?
> 
> I have no other reasons than the above.
> 
> People like Russell (clkdevice) and Liam Girdwood (regulator)
> who I know are smarter than me and have worked with
> these subsystems for years choose that model, so I trust
> their judgement.
I would agree the overhead of using strings is negligible if you compare
the benefits it gives in usability and being easy for someone to
configure.
Jassi being samsung asoc maintainer should already agree to that :-)


-- 
~Vinod
