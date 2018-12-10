Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7748CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:55:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FFA2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPPsb+Cz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHPCCWjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FFA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0BqGK/QGdUvSgGMs4uOuWyb0H60BnbVDaEwTx9Z/a4=; b=LPPsb+CzrrFqJa
	JaTflv3OaqwQsFOv1J98cUP7haFqnrQJ/FicB8X9vzs/a15KsaBFSSgQM8Bh70MrDM97AQ8ISxraU
	3sdvwCaasr7RfM90bIBAy0WklhWXQFcfsgPc85iGyY170QaJjlqAqMs136Dp65pAeBLODNxtgyBl+
	ANl10UTosQWr8i4pSdcjpRuhQ+QdxsYqqurrNBlAMlN80gpaRK0CbV4oWxie/44DBaHXyJbDLL4tY
	eRCwGTWofbVNEEhIvPIE8dc9D77ZuyvHwvFS6X0jHXSPxpWDy4b1afcrzuqkHjs5CqoCJ7w0BRjH7
	I+jZ7xTMCnAsxZSHJoPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWNuI-0005eW-Pj; Mon, 10 Dec 2018 15:55:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWNu6-0005OK-Pm
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 15:55:36 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D9CF2086D
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544457320;
 bh=tdWexW1Em2QodRxbR0688bp4OOd6b37LaRogcjCXLQ8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VHPCCWjM+xyX0xQvBVkHWlE/CTNadjBibh+Fx6AaPoaXhV001GGtkgaew1uuYHopP
 dLGv59342si/I1E9t5gCzNxmBKWmYbPfaYqzboxJnStHz+Cp/bOAkvkF3vM/LprAtQ
 oUHRJ+sKgPM9iop4dHFYe+ghq1lMeYyqT8TazAFs=
Received: by mail-qt1-f173.google.com with SMTP id d18so12768083qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 07:55:20 -0800 (PST)
X-Gm-Message-State: AA+aEWYHyXUADYsPNq+5wHM2hHsKQjCb69ag0pirPFGTqwbH/Kri8p13
 NUK82skZ5lDIAyTDtCPSCll1zgLev8Lty39hlQ==
X-Google-Smtp-Source: AFSGD/WdL3jH1aB2r9XkwGH03MZ292O51eVgVHWN8vXa/0befR9IQoem6DmJxhW5WLlW09pkSQBDXEKgsydwEU2bHRM=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr12721557qts.144.1544457319305; 
 Mon, 10 Dec 2018 07:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-2-robh@kernel.org>
 <CAK7LNARgyL+Pq+SCkUUKnMny4nDw1L4zEevdzqbyGGAoE+BXUA@mail.gmail.com>
In-Reply-To: <CAK7LNARgyL+Pq+SCkUUKnMny4nDw1L4zEevdzqbyGGAoE+BXUA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 10 Dec 2018 09:55:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhNq2LWffT5XK9nd+p_7oYacMmsQidP_cmjkd7DsNmNQ@mail.gmail.com>
Message-ID: <CAL_JsqLhNq2LWffT5XK9nd+p_7oYacMmsQidP_cmjkd7DsNmNQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/34] kbuild: Add support for DT binding schema checks
To: Masahiro Yamada <yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_075531_475132_95DFDBCD 
X-CRM114-Status: GOOD (  32.86  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 10:47 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> On Tue, Dec 4, 2018 at 6:32 AM Rob Herring <robh@kernel.org> wrote:
> >
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can passed in with a schema file(s) to use
> > for validation. This makes it easier to find and fix errors generated by
> > a specific schema.
> >
> > Currently, the validation targets are separate from a normal build to
> > avoid a hard dependency on the external DT schema project and because
> > there are lots of warnings generated.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .gitignore                                   |  1 +
> >  Documentation/Makefile                       |  2 +-
> >  Documentation/devicetree/bindings/.gitignore |  1 +
> >  Documentation/devicetree/bindings/Makefile   | 33 ++++++++++++++++++++
> >  Makefile                                     | 11 +++++--
> >  scripts/Makefile.lib                         | 24 ++++++++++++--
> >  6 files changed, 67 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/.gitignore
> >  create mode 100644 Documentation/devicetree/bindings/Makefile
> >
> > diff --git a/.gitignore b/.gitignore
> > index 97ba6b79834c..a20ac26aa2f5 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -15,6 +15,7 @@
> >  *.bin
> >  *.bz2
> >  *.c.[012]*.*
> > +*.dt.yaml
> >  *.dtb
> >  *.dtb.S
> >  *.dwo
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2ca77ad0f238..9786957c6a35 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for Sphinx documentation
> >  #
> >
> > -subdir-y :=
> > +subdir-y := devicetree/bindings/
> >
> >  # You can set these variables from the command line.
> >  SPHINXBUILD   = sphinx-build
> > diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> > new file mode 100644
> > index 000000000000..d9194c02dd08
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/.gitignore
> > @@ -0,0 +1 @@
> > +*.example.dts
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> > new file mode 100644
> > index 000000000000..ee0110dd8131
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +DT_DOC_CHECKER ?= dt-doc-validate
> > +DT_EXTRACT_EX ?= dt-extract-example
> > +DT_MK_SCHEMA ?= dt-mk-schema
> > +DT_MK_SCHEMA_FLAGS := $(if $(DT_SCHEMA_FILES), -u)
> > +
> > +quiet_cmd_chk_binding = CHKDT   $<
> > +      cmd_chk_binding = (set -e; \
> > +                         $(DT_DOC_CHECKER) $< ; \
> > +                         mkdir -p $(dir $@) ; \
> > +                         $(DT_EXTRACT_EX) $< > $@ )
> > +
> > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > +       $(call if_changed,chk_binding)
> > +
> > +DT_TMP_SCHEMA := .schema.yaml.tmp
> > +extra-y += $(DT_TMP_SCHEMA)
> > +
> > +quiet_cmd_mk_schema = SCHEMA  $@
> > +      cmd_mk_schema = mkdir -p $(obj); \
> > +                      rm -f $@; \
> > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $<
>
>
> I think '$<' is wrong.
>
> '$<' is replaced with the first prerequisite.

Indeed.

> You can easily check what is happening here.
>
> $ cat   Documentation/devicetree/bindings/..schema.yaml.tmp.cmd
> cmd_Documentation/devicetree/bindings/.schema.yaml.tmp := mkdir -p
> Documentation/devicetree/bindings; rm -f
> Documentation/devicetree/bindings/.schema.yaml.tmp; dt-mk-schema  -o
> Documentation/devicetree/bindings/.schema.yaml.tmp
> Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
>
>
> So, the dt-validater will check only binding from ti,davinci.yaml,
> which is almost useless.
>
>
>
> If I understand it correctly,
> .schema.yaml.tmp should contain all binding yaml.
>
>
> I fixed it up like follows:
>
> diff --git a/Documentation/devicetree/bindings/Makefile
> b/Documentation/devicetree/bindings/Makefile
> index ee0110d..267458f 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -19,7 +19,7 @@ extra-y += $(DT_TMP_SCHEMA)
>  quiet_cmd_mk_schema = SCHEMA  $@
>        cmd_mk_schema = mkdir -p $(obj); \
>                        rm -f $@; \
> -                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $<
> +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
> $(filter-out FORCE, $^)

Thanks, I incorporated this fix.

>
>  DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
>  DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
>
>
>
> Then, I see another error.

I fixed this with this change:

@@ -27,7 +27,7 @@ DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
 extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
 extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))

-$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(obj)/,$(patsubst
$(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
+$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst
$(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))

 $(obj)/$(DT_TMP_SCHEMA): $(addprefix $(srctree)/, $(DT_SCHEMA_FILES)) FORCE
        $(call if_changed,mk_schema)

>
>
>   SCHEMA  Documentation/devicetree/bindings/.schema.yaml.tmp
> Traceback (most recent call last):
>   File "/home/masahiro/ref/yaml-bindings/tools/dt-mk-schema", line 32,
> in <module>
>     schemas = dtschema.process_schemas(args.schemas, core_schema=(not
> args.useronly))
>   File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
> line 359, in process_schemas
>     sch = process_schema(os.path.abspath(filename))
>   File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
> line 314, in process_schema
>     schema = load_schema(filename)
>   File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
> line 80, in load_schema
>     return yaml.load(f.read())
>   File "/usr/lib/python3.5/codecs.py", line 321, in decode
>     (result, consumed) = self._buffer_decode(data, self.errors, final)
> UnicodeDecodeError: 'utf-8' codec can't decode byte 0xd0 in position
> 0: invalid continuation byte
> Documentation/devicetree/bindings/Makefile:33: recipe for target
> 'Documentation/devicetree/bindings/.schema.yaml.tmp' failed
> make[1]: *** [Documentation/devicetree/bindings/.schema.yaml.tmp] Error 1
> Makefile:1278: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
>
>
>
>
>
>
> BTW, I cannot build *.dt.yaml
>
>
>
>   DTC     arch/arm/boot/dts/alpine-db.dt.yaml
> FATAL ERROR: Unknown output format "yaml"
> scripts/Makefile.lib:313: recipe for target
> 'arch/arm/boot/dts/alpine-db.dt.yaml' failed
> make[1]: *** [arch/arm/boot/dts/alpine-db.dt.yaml] Error 1
> make[1]: *** Deleting file 'arch/arm/boot/dts/alpine-db.dt.yaml'
> Makefile:1262: recipe for target 'dtbs_check' failed
>
>
>
>
> I use linux-next.
>
>
> script/dtc/dtc does not understand '-O yaml'
>
>
> I also tried the upstream DTC project with no success.
>
>
> Where can I get dtc with yaml support?

You need libyaml and its headers. I'll try to make this a better error
message. For now, libyaml is optional so we don't break everyone just
building dtbs.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
