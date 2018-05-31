From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 31 May 2018 12:08:30 -0500
Subject: [PATCH v2 0/2] arm64: align KPTI interface with x86
Message-ID: <20180531170832.14263-1-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 supports KPTI, but support isn't documented and KPTI can be enabled
or disabled silently. Also, x86_64 supports the nopti kernel parameter,
but ARM64 doesn't.

Add the nopti argument, update the documentation so that ARM64 as well
as x86 supports nopti, add documentation for the existing kpti parameter,
and revise how kpti is logged.

--Mark Langsdorf

Changes from v1:
- Two patches dealing with debugfs dropped as x86 doesn't have this capability
- Documentation changed so that the existing kpti argument is documented,
  instead of a pti argument similar to what x86 uses but arm64 does not.
- when logging kpti status, made it clear when status is set by default
