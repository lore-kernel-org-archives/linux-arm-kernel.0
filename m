From: gorcunov@openvz.org (Cyrill Gorcunov)
Date: Tue, 19 Feb 2013 10:48:00 +0400
Subject: [patch 0/2] make kcmp own config entry
Message-ID: <20130219064800.719149796@openvz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys, kcmp syscall (according to git log) is being wired up for a number
of architectures other than x86 (where it was developed initially). But the
main Makefile which controling its compilation is still x86 dependant.

Thus I think kcmp may deserve own config entry unrelated to arch type it
is being compiled for. In case if some particular arch doesn't support it
ENOSYS should be returned. This small set also wires up kcmp for ARM.

Please take a look, thanks!

	Cyrill
