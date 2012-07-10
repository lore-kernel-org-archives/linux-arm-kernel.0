From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Tue, 10 Jul 2012 14:22:13 +0530
Subject: [PATCH 5/6] Clk: SPEAr1340: fix sys clock parent source and
 corresponding mask value
In-Reply-To: <20120709225700.GB16202@gmail.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
 <CAOh2x=n9dOaxW7hibg3M5XYTtbMkyrvUMt0ORKzWLULxUNtXEg@mail.gmail.com>
 <4FFAC8D2.4080601@st.com>
 <CAOh2x=k5Tx2Gjrk1uRod-N-6gvYSeEKiZgms8gQfJ61TL8RXCQ@mail.gmail.com>
 <20120709225700.GB16202@gmail.com>
Message-ID: <20120710085213.GI29798@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Jul 09, 2012 at 03:57:00PM -0700, Mike Turquette wrote:
> On 20120709-13:34, viresh kumar wrote:
> > On Mon, Jul 9, 2012 at 1:04 PM, vipul kumar samar
> > <vipulkumar.samar@st.com> wrote:
> > > On 7/9/2012 4:34 PM, viresh kumar wrote:
> > >>
> > >> On Mon, Jul 9, 2012 at 11:31 AM, Shiraz Hashim<shiraz.hashim@st.com>
> > >> wrote:
> > >>>
> > >>> From: Vipul Kumar Samar<vipulkumar.samar@st.com>
> > >>>
> > >>> sys_clk have multiple parents and selection of parent is depends on
> > >>
> > >>
> > >> s/ is//
> > 
> > I hope you haven't missed this comment :)
> > 
> > >>>   static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
> > >>> -static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
> > >>> -       "sys_synth_clk", "none", "pll2_clk", "pll3_clk", };
> > >>> +static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
> > >>> +       "pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk",
> > >>> "pll3_clk", };
> > >>
> > >>
> > >> Don't know what would be the implication of this?
> > >>
> > >> @Mike: Can you please tell us what should we do in such cases?
> > >>
> > >
> > > Is there any other solution for such cases ???
> > 
> > That's what i have asked mike for :)
> > Probably you can go through the clock framework code and check how these
> > names are used. Shouldn't be too complex to understand.
> > 
> 
> I assume this change has been tested and wouldn't be posted if modifying
> the parent names broke things.

Yes, it is working fine for us.

--
regards
Shiraz
