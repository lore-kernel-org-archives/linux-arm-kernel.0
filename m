From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 10:31:38 -0600
Subject: [PATCH v1 1/7] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <dfb3192a-d5b6-029e-b8cb-65a628a0c30b@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
 <1484573344-11609-2-git-send-email-yannick.fertre@st.com>
 <2080174.sm3cyM9MmB@avalon>
 <dfb3192a-d5b6-029e-b8cb-65a628a0c30b@st.com>
Message-ID: <20170119163138.va23ppx3ictp6wjr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 04:16:01PM +0000, Yannick FERTRE wrote:
> On 01/16/2017 09:30 PM, Laurent Pinchart wrote:
> > Hi Yannick,
> >
> > Thank you for the patch.
> >
> > On Monday 16 Jan 2017 14:28:58 Yannick Fertre wrote:
> >> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> >> ---
> >>  .../devicetree/bindings/display/st,ltdc.txt        | 57 ++++++++++++++++++
> >>  1 file changed, 57 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/display/st,ltdc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/st,ltdc.txt
> >> b/Documentation/devicetree/bindings/display/st,ltdc.txt new file mode
> >> 100644
> >> index 0000000..20e89da
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/st,ltdc.txt
> >> @@ -0,0 +1,57 @@
> >> +* STMicroelectronics STM32 lcd-tft display controller
> >> +
> >> +- st-display-subsystem: Master device for DRM sub-components
> >> +  This device must be the parent of all the sub-components and is
> >> responsible
> >> +  of bind them.
> >
> > Why do you need this ? At a quick glance the ltdc node should be enough.
> Hi Laurent,
> To prepare next device upstream of dsi, we need a master node 
> "st-display-subsystem" and a sub node "st,ltdc". It's the same kind of 
> node than st,stih4xx.

No, you don't. That's what OF graph is for. The DRM driver binds to the 
LCD controller node and walks the graph to find the DSI node and then 
the panel.

Rob
