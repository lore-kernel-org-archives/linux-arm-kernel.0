Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C0C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:32:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592562084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYWjO28j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592562084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CzEzybp8SO7BGQdduTQ803/qcrdyXuVg4XgMcO+NeEo=; b=VYWjO28jzKCPBh
	sDvdBKymlYIliRJUZF4qxlqQX6OeMowVanGPFzuz+UeKxLSgq/0zFJZ9LQvZHps+VvQtHGhOrvkMR
	4ouEJgm5yc+r9A1FOWOPklMNHZfbuZYy+1lmIt1qwbWh3+TNcs2THJVhY//19lLZ3OvR2uJF16A3w
	udgLiGlNTS4Vl/0v+yv0sgvucy2T8bWPTy0hzK3bR05M24Wz5aNlJLBTOvlNDv+1NFFmpuA2aTlMN
	wH98vhulX8doPaUdE6SaLtiL92nTRcb9A0Wc7PNsZf5Zxr91Dly8aQzVWfTNpQZJE+jb8Hk5tyo33
	yq24cNxddCYU7JiljQjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSEL-0001pP-UH; Mon, 10 Dec 2018 20:32:41 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSEI-0001oV-Qf
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:32:40 +0000
Received: by mail-oi1-f194.google.com with SMTP id h25so10162586oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z/1koWbCGQMD5zy9wBBmxwZQ1rWEBMNYAqc6ECB9skQ=;
 b=TJLGIRtDR6C5d5ecK8TvkPsR5fGZEQJm3xiCJpyIMOiCWfKCWKT3xJfdfEp2Y0hQLt
 pA+BT085bG2sAEvLlnInlit2w8a+2jr9o9gIluyLPxSv8yqVPFXg5Lb8WEee59pQK1tV
 TQnXd2fvWq0Ce2v1+LIZQmDjYwu771+EQjCedCv9wmWFkVjSfdZWkuATfWPmqoxyLxYC
 DqoiRPiOKkBJLw+RwR6a6+6Me+SmTvZ1Uwsbk88kkqoJ9ci/I+h0oOTkWs/tYDS6qhvc
 m7P4xfH//SOWgXlmkYcrB6h99O8qkP6RkcmTqzIWm4u0LKQWdk7tQtYb3s3dXIl0TJRI
 x1rQ==
X-Gm-Message-State: AA+aEWbukjicGigHBGJYtehG8pVJ3KT0Tg+YK+3nB3vAVvY6hOuQOy5D
 DXh3r2iTrMgyJTP2w+cZ7A==
X-Google-Smtp-Source: AFSGD/UTOysIXvcEQiFKuCHLs2ATAjNMwlkcajeldIQbdkDgNta5snxM1Nr638bmDd8Q/+Ck51b8Lw==
X-Received: by 2002:aca:684a:: with SMTP id d71mr7974897oic.264.1544473947171; 
 Mon, 10 Dec 2018 12:32:27 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id a66sm6223860oib.42.2018.12.10.12.32.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 12:32:26 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kbuild: Add support for DT binding schema checks
Date: Mon, 10 Dec 2018 14:32:25 -0600
Message-Id: <20181210203225.11179-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_123238_862715_415F8563 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Jonathan Corbet <corbet@lwn.net>, Frank Rowand <frowand.list@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <grant.likely@arm.com>, Michal Marek <michal.lkml@markovi.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the build infrastructure for checking DT binding schema
documents and validating dts files using the binding schema.

Check DT binding schema documents:
make dt_binding_check

Build dts files and check using DT binding schema:
make dtbs_check

Optionally, DT_SCHEMA_FILES can passed in with a schema file(s) to use
for validation. This makes it easier to find and fix errors generated by
a specific schema.

Currently, the validation targets are separate from a normal build to
avoid a hard dependency on the external DT schema project and because
there are lots of warnings generated.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Fix error causing only 1st schema file to get used.
- Add a more useful error message when dtc is missing YAML support 
telling the user they need to install libyaml devel package.

 
 .gitignore                                   |  1 +
 Documentation/Makefile                       |  2 +-
 Documentation/devicetree/bindings/.gitignore |  1 +
 Documentation/devicetree/bindings/Makefile   | 33 +++++++++++++++++
 Makefile                                     | 11 ++++--
 scripts/Makefile.lib                         | 37 ++++++++++++++++++--
 6 files changed, 80 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.gitignore
 create mode 100644 Documentation/devicetree/bindings/Makefile

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..a20ac26aa2f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@
 *.bin
 *.bz2
 *.c.[012]*.*
+*.dt.yaml
 *.dtb
 *.dtb.S
 *.dwo
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ca77ad0f238..9786957c6a35 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Sphinx documentation
 #
 
-subdir-y :=
+subdir-y := devicetree/bindings/
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
new file mode 100644
index 000000000000..d9194c02dd08
--- /dev/null
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -0,0 +1 @@
+*.example.dts
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
new file mode 100644
index 000000000000..43f8657ab070
--- /dev/null
+++ b/Documentation/devicetree/bindings/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+DT_DOC_CHECKER ?= dt-doc-validate
+DT_EXTRACT_EX ?= dt-extract-example
+DT_MK_SCHEMA ?= dt-mk-schema
+DT_MK_SCHEMA_FLAGS := $(if $(DT_SCHEMA_FILES), -u)
+
+quiet_cmd_chk_binding = CHKDT   $<
+      cmd_chk_binding = (set -e; \
+                         $(DT_DOC_CHECKER) $< ; \
+                         mkdir -p $(dir $@) ; \
+                         $(DT_EXTRACT_EX) $< > $@ )
+
+$(obj)/%.example.dts: $(src)/%.yaml FORCE
+	$(call if_changed,chk_binding)
+
+DT_TMP_SCHEMA := .schema.yaml.tmp
+extra-y += $(DT_TMP_SCHEMA)
+
+quiet_cmd_mk_schema = SCHEMA  $@
+      cmd_mk_schema = mkdir -p $(obj); \
+                      rm -f $@; \
+                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
+
+DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
+DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
+
+extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
+extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
+
+$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
+
+$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(srctree)/, $(DT_SCHEMA_FILES)) FORCE
+	$(call if_changed,mk_schema)
diff --git a/Makefile b/Makefile
index 2f36db897895..ff59adf43300 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,10 +1232,13 @@ ifneq ($(dtstree),)
 %.dtb: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install
+PHONY += dtbs dtbs_install dt_binding_check
 dtbs: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+dtbs_check: prepare3 dt_binding_check
+	$(Q)$(MAKE) $(build)=$(dtstree) CHECK_DTBS=1
+
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
 
@@ -1249,6 +1252,9 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
+
 # ---------------------------------------------------------------------------
 # Modules
 
@@ -1611,7 +1617,8 @@ clean: $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '*.ko.*' -o -name '*.dtb' -o -name '*.dtb.S' \
+		-o -name '*.ko.*' \
+		-o -name '*.dtb' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su'  \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468f9bda..6a3450b20041 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -61,6 +61,11 @@ real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))
 extra-y				+= $(dtb-y)
 extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
+ifneq ($(CHECK_DTBS),)
+extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+endif
+
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
@@ -284,13 +289,41 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O dtb -o $@ -b 0 \
+	$(DTC) -O $(2) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtc)
+	$(call if_changed_dep,dtc,dtb)
+
+DT_CHECKER ?= dt-validate
+DT_BINDING_DIR := Documentation/devicetree/bindings
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/.schema.yaml.tmp
+
+quiet_cmd_dtb_check =	CHECK   $@
+      cmd_dtb_check =	$(DT_CHECKER) -p $(DT_TMP_SCHEMA) $@ ;
+
+define rule_dtc_dt_yaml
+	$(call cmd_and_fixdep,dtc,yaml)		\
+	$(call echo-cmd,dtb_check) $(cmd_dtb_check)
+endef
+
+cmd_dtc_yaml_chk = \
+	if ! echo "/dts-v1/; /{};" | $(DTC) -I dts -O yaml > /dev/null ; then \
+		echo "*"; \
+		echo "* dtc needs libyaml for DT schema validation support."; \
+		echo "* Install the necessary libyaml development package from your distro."; \
+		echo "*"; \
+		false; \
+	fi; \
+	touch $@
+
+$(objtree)/scripts/dtc/.dtc-yaml-chk.tmp: $(DTC) FORCE
+	$(call if_changed,dtc_yaml_chk)
+
+$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE | $(objtree)/scripts/dtc/.dtc-yaml-chk.tmp
+	$(call if_changed_rule,dtc_dt_yaml)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
