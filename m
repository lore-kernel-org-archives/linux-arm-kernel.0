From: robh@kernel.org (Rob Herring)
Date: Tue, 11 Sep 2018 21:52:03 -0500
Subject: i.MX DT memory nodes
In-Reply-To: <CAOMZO5DTW8KWKwxj8pnS6zv8VhiuFDc-bf=+k=1c4sgqubEPVA@mail.gmail.com>
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
 <CAOMZO5DTW8KWKwxj8pnS6zv8VhiuFDc-bf=+k=1c4sgqubEPVA@mail.gmail.com>
Message-ID: <CAL_JsqJSe20Zj4Fsxw=UCJ4DiqUUjY9Sxa_hZrsv+s2XP_+MZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 9:38 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rob,
>
> On Tue, Sep 11, 2018 at 6:54 PM, Rob Herring <robh@kernel.org> wrote:
> > It appears that many i.MX platforms have duplicate, incomplete memory
> > nodes with both "memory" and "memory@<addr>" nodes. Are you all aware
> > of this? Plan to fix it? I guess u-boot fixes things enough to work.
>
> I was not aware.
>
> I spent some time fixing all the memory node errors reported by dtc with W=1.

Unfortunately, dtc is not catching it because we have 'memory' with
just device_type and 'memory@<addr>' with reg.

> Any suggestions on how to fix the remaining issues?

Make sure every memory@<addr> has device_type added and remove the
'memory' nodes.

> Also, how can I trigger such warnings?

Install the schema tools:

pip3 install git+https://github.com/robherring/yaml-bindings.git at master
--process-dependency-links

Use this kernel branch with the build support:

https://github.com/robherring/linux/commits/yaml-bindings

And this dtc:

https://github.com/robherring/dtc/tree/yaml

Rob
