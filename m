From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 17 Oct 2013 16:19:57 +0200
Subject: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <525FAEED.7030207@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com>
Message-ID: <20131017141957.GE14104@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:33 Thu 17 Oct     , srinivas kandagatla wrote:
> On 17/10/13 08:27, Maxime COQUELIN wrote:
> > ...
> >>> >> +
> >>> >> +static struct of_device_id st_i2c_match[] = {
> >>> >> +     { .compatible = "st,comms-ssc-i2c", },
> >> > the rules is to put the first soc that use the ip in the compatible
> >> > as st,sti7100-scc-i2c
> > Ok. There are no plans to upstream the SH4 platforms, it will only 
> > remains in stlinux.com.
> > Maybe I can set the first ARM platform (STiH415)?
> > That would give st,stih415-ssc-i2c.
> NAK, for st,stih415-ssc-i2c naming.
> 
> IMO, this makes sense when the same IP integration done on different SOC
> changes slightly/very differently.
> 
> But in this case the "comms" IP remains unchanged across all the SOCs.
> 
> I would still prefer "st,comms-ssc-i2c", allowing a single device driver
> to match against several SoCs. ST "comms" IP it is integrated across all
> the STi series of SoCs, so we don't want to add new entry in compatible
> for every new SOC.

you never need this you always the first SoC that's all

see other bindings on at91 as example sorry NACK

Best Regards,
J.
> 
> 
> Thanks,
> srini
> 
> > 
> > Thanks for the review,
> > Maxime
> > 
> >> >
> 
