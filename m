Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C89C6783C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:24:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D3120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q2zkfV/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D3120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1XfadNaMyRuT+2WgmSpkbLSj6LdRKEWQienZwC00RgI=; b=Q2zkfV/d+DosDm
	N7x5vsOmK+esu1TtwD4GYax3JiI3WH/zLEh7xk0vWrEVgP8THpF0qkNyZ5/RI7Rd8s+eNcRSPMhen
	zSv9gQOXKmytFBRJ3Y+MsMh3QqV/4c/xE7D+l+BL/HGVKV8Jl98LCWbgAyM+ezGOdmnth9lehBcAD
	G26vWS+uU2lc8q40r6Nk2ibvKSJzE7MyW1fbOn4Hx/RMgcl6jtQHgmIlW+Cj4OEtENc4eLQa1cjU+
	6rkbKfSDblfLuy97ornyOj/ZCwuKWpw55q13ocGCKpCiuKK3so+buWWsNe5N3PNyvaUsAicDQppoV
	Ipz4k85QTkYYgVwJcClQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWoZu-0005fM-MX; Tue, 11 Dec 2018 20:24:26 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWoZp-0005dc-6o
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 20:24:23 +0000
Received: by mail-ot1-f68.google.com with SMTP id 32so15338134ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 12:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qDEl5D7sjNExZPgDsPayoPbNtf9cuUrPusIJ99/11Fs=;
 b=qxT0rC+pYP22YW/ip/G/GGAeNPmeFnUs5BxNOYIcChkhsnC5WU0POhbMHDl0cq6j5o
 jMzcYq/VtWZ2hT3XrMQ3lq52ZJopG0a4G95LUUOt1S5Cu4O5DYuhz9ITwAHCxr4x+Iob
 pT2fCtVk68nK7Esezo4t8Jjbcxpvu7ON05wigpE6XMFxN6dR3Q6mFQ8P5Q9PR5kFqALf
 Sb1KXWp2JAD2hKDGA+NjZ/t8m3OryQF0tY/dG4AQay0qlGiGC5DpDHCsX1mW5Bur/Zt7
 MFup5NFJXJm+19qN+VOFRDCz8x1RqIimBtB+yH/IQhk18TlPiCx3R42Zk+xl4zVBxnZg
 m93A==
X-Gm-Message-State: AA+aEWYg3la/gloTfVQR0HqTkqvTJARJTserv9e3RXbnksgGFro9VX6G
 dddlTSy6ROhzAT7umCndMg==
X-Google-Smtp-Source: AFSGD/Ub2SvNQ//jyxN7kG/dzI9pQIkB5mZMsjKnHNEQKUsianwAcKxOxEAWYW850wtYb3gHq/udiA==
X-Received: by 2002:a05:6830:d:: with SMTP id
 c13mr13187750otp.82.1544559848822; 
 Tue, 11 Dec 2018 12:24:08 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id z9sm7327127oiz.21.2018.12.11.12.24.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 12:24:08 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4] kbuild: Add support for DT binding schema checks
Date: Tue, 11 Dec 2018 14:24:06 -0600
Message-Id: <20181211202406.27721-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_122421_274740_27DF309E 
X-CRM114-Status: GOOD (  17.32  )
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
 Michal Marek <michal.lkml@markovi.net>, Grant Likely <grant.likely@arm.com>,
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

Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
use for validation. This makes it easier to find and fix errors
generated by a specific schema.

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
v4:
- Rework libyaml check and error message with Masahiro's version
- Simplify build rules and dependencies


 .gitignore                                   |  1 +
 Documentation/Makefile                       |  2 +-
 Documentation/devicetree/bindings/.gitignore |  2 ++
 Documentation/devicetree/bindings/Makefile   | 27 ++++++++++++++++++++
 Makefile                                     | 13 +++++++---
 scripts/Makefile.lib                         | 24 +++++++++++++++--
 scripts/dtc/Makefile                         |  4 +++
 7 files changed, 67 insertions(+), 6 deletions(-)
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
index 000000000000..ef82fcfcccab
--- /dev/null
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -0,0 +1,2 @@
+*.example.dts
+processed-schema.yaml
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
new file mode 100644
index 000000000000..6e5cef0ed6fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+DT_DOC_CHECKER ?= dt-doc-validate
+DT_EXTRACT_EX ?= dt-extract-example
+DT_MK_SCHEMA ?= dt-mk-schema
+DT_MK_SCHEMA_FLAGS := $(if $(DT_SCHEMA_FILES), -u)
+
+quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
+      cmd_chk_binding = $(DT_DOC_CHECKER) $< ; \
+                        $(DT_EXTRACT_EX) $< > $@
+
+$(obj)/%.example.dts: $(src)/%.yaml FORCE
+	$(call if_changed,chk_binding)
+
+DT_TMP_SCHEMA := processed-schema.yaml
+extra-y += $(DT_TMP_SCHEMA)
+
+quiet_cmd_mk_schema = SCHEMA  $@
+      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
+
+DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
+DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
+
+extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
+extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
+
+$(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
+	$(call if_changed,mk_schema)
diff --git a/Makefile b/Makefile
index 2f36db897895..a3e2db2a3119 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,10 +1232,13 @@ ifneq ($(dtstree),)
 %.dtb: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install
-dtbs: prepare3 scripts_dtc
+PHONY += dtbs dtbs_install dt_binding_check
+dtbs dtbs_check: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+dtbs_check: export CHECK_DTBS=1
+dtbs_check: dt_binding_check
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
index 8fe4468f9bda..723b33c942df 100644
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
@@ -284,13 +289,28 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
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
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.yaml
+
+quiet_cmd_dtb_check =	CHECK   $@
+      cmd_dtb_check =	$(DT_CHECKER) -p $(DT_TMP_SCHEMA) $@ ;
+
+define rule_dtc_dt_yaml
+	$(call cmd_and_fixdep,dtc,yaml)		\
+	$(call echo-cmd,dtb_check) $(cmd_dtb_check)
+endef
+
+$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_rule,dtc_dt_yaml)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 056d5da6c477..5f227d8d39d8 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -12,6 +12,10 @@ dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 HOST_EXTRACFLAGS := -I$(src)/libfdt
 
 ifeq ($(wildcard /usr/include/yaml.h),)
+ifneq ($(CHECK_DTBS),)
+$(error dtc needs libyaml for DT schema validation support. \
+	Install the necessary libyaml development package.)
+endif
 HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs	+= yamltree.o
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
