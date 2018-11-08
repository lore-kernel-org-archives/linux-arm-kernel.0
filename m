From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Nov 2018 15:32:49 -0600
Subject: [PATCH 00/36] Devicetree schema
In-Reply-To: <CAApg2=QtTWxi6rhC-r971-HXPP2QEP=ZRRwS7nHQjKRMLGct7g@mail.gmail.com>
References: <CAApg2=QtTWxi6rhC-r971-HXPP2QEP=ZRRwS7nHQjKRMLGct7g@mail.gmail.com>
Message-ID: <CAL_JsqL+7=zB3ze8cPNC1wZHX_FhP6wF9Xvrb_rTDgH90PDXzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2018 at 1:54 PM Marta Rybczynska <rybczynska@gmail.com> wrote:
>
> Rob,
> The patch set does convert the documentation files. Could you explain
> the workflow of verifying a DTS? From what I can understand we can
> validate YAML devicetrees, and the schema files against the
> meta-schemas, but I see no tool for DTS to YAML conversion in your
> tools. Do you use https://github.com/pantoniou/yamldt ?

No, I'm not using that. dtc supports yaml output now. The kernel copy
of dtc has this support in 4.20. You need libyaml headers installed to
enable the support. The output format is intended only for validation
and could possibly change.

The 'dtbs_check' target will do a dts->dt.yaml pass of all targets in
$(dtb-y) with dtc and then run the .dt.yaml files through the schema
validation.

There's also a presentation here:
https://connect.linaro.org/resources/yvr18/yvr18-404/

Rob
