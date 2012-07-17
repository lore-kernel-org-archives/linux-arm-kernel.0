From: deepak.sikri@st.com (deepaksi)
Date: Tue, 17 Jul 2012 15:30:34 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
 <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
Message-ID: <500537C2.1030501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh,



On 7/13/2012 4:00 PM, viresh kumar wrote:
> On Fri, Jul 13, 2012 at 10:23 AM, Vipul Kumar Samar
> <vipulkumar.samar@st.com>  wrote:
>> Use AUXDATA to pass platform data for Ethernet controller.
> Adding Stefan and Peppe.
>
> I understand why you can't send all platform data from DT.
> Let me elaborate the problem statement
>
> stmmac is used by platforms with and without DT.
> - Without DT will pass platform data directly, without any issues.
> - With DT have to pass all data, some of that via DT and other without
> DT, like routines
>    (atleast for now)
>
> For now what I suggest is, update DT support for whatever we can..
> i.e. support Maximum
> properties there. As finally we will support everything via DT, no
> platform data.
>
> Whatever is left, that can't be passed via DT, like routine, pass it
> from platform data
> and merge both these versions of platform data in driver, keeping DT
> ones in priority.
>
> i.e. Whatever is defined in DT properties must come from there and
> left outs from
> platform data.

I do differ on the point over here. I do believe that the code for now 
should be left as into mutually
exclusive sections.
As you said, without DT, the platform data would exist without any 
problem, Thats fine

But with DT also, as of now since the DT is still evolving we should not 
merge the data and keep it at
two places. The reasons being.
The stmmac driver is being used by multiple platforms, lets say within 
spear we have different variants
requiring different configurations and dividing those configurations at 
two different places will require larger
maintenance.Any more changes in driver that has dependency on the 
platform data will require updates,
and more such conflicts will arrive related to maintenance.

Lets keep the platform data as a part of AUXDATA for now, till the tree 
evolves fully specifically if DT is being
used.

Deepak




> --
> viresh
> .
>
