From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 21 Jan 2013 16:01:19 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP: some clock/hwmod fixes for v3.8-rc
Message-ID: <alpine.DEB.2.00.1301211557530.8450@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-v3.8-rc

for you to fetch changes up to bdcc61275232db897ba831f87a16df98ab248571:

  ARM: OMAP2: Fix missing omap2xxx_clkt_vps_late_init function calls (2013-01-18 16:48:16 -0700)

- ----------------------------------------------------------------
A few OMAP integration fixes for v3.8-rc, for OMAP4 audio and OMAP2 reboot.

Basic test logs are available here:

    http://www.pwsan.com/omap/testlogs/prcm_fixes_c_v3.8-rc/20130121073904/

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc4 (7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619)):
   text     data      bss    total  kernel
      0        0        0        0  am33xx_only
     +8      +24        0      +32  n800_multi_omap2xxx
     +4       -8        0       -4  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
     -8       +8        0        0  omap2plus_defconfig
     +4      +24        0      +28  omap2plus_defconfig_2430sdp_only
     -8       +8        0        0  omap2plus_defconfig_cpupm
     -8       +8        0        0  omap2plus_defconfig_no_pm
     -8       +8        0        0  omap2plus_defconfig_omap2_4_only
    -16      +16        0        0  omap2plus_defconfig_omap3_4_only
     -8       +8        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
     -8       +8        0        0  rmk_omap4430_sdp_allnoconfig
    -16      +16        0        0  rmk_omap4430_sdp_oldconfig

Jon Hunter (1):
      ARM: OMAP2: Fix missing omap2xxx_clkt_vps_late_init function calls

Peter Ujfalusi (2):
      ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
      ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

 arch/arm/mach-omap2/cclock2420_data.c      |    2 ++
 arch/arm/mach-omap2/cclock2430_data.c      |    2 ++
 arch/arm/mach-omap2/cclock44xx_data.c      |   13 ++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +++++-
 4 files changed, 15 insertions(+), 8 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ/WYEAAoJEMePsQ0LvSpLjwcP/3ZgPMHcwk+/rdSOtCF9BR4V
BFc9GSyUnj5jJMmVo2yixHgM6hnf0nqP9lEHW6wYaqFF7wb6swo5mKCsK3VErgF/
xJXL1j9DmdnnF+uUeoRmKlNkQ2y2+zkbHCBY8A6zxzKQMYW6xSwkhM1Jdmw55Vxn
ROgPXuzjOnXUsTtodYsVkW/3hGNKCxoP8/hH7M+GcQVql9Iebh2E/efW67pSFTvp
ChisfYiHWJWzDso8FfKkLwYHSZfK5qq3KNFgRq2n0xuxEsJMGqM5rKaQypJ6LMK/
ExvPgFAhgHnsSvtESNWAKsAXDtVvr2z/HYPIsoCVYUy7C33P857uQpbIXuD4gS4w
CLon1M9k4Wpuzd4Da/WY6O8L6goCrTuL7Cx1ayWBmvZNDpwNAUVQi8k1Ei9vcFiv
N3vxutc/QrYQ11x7uNe2A8XWp8fsVvwQ6+XiVk96ZXgKe+Fc1COOz17lMyxhJqdo
PhAXvnvo5avzDueiu4AluFkIwsNl5vDqphkxqhOdlDzcuZHN4dzguoN/fKIbSXfy
fKS6GXDwU1vTTpvzbefdDUiVU+rEi9HIbXv8tkXp5FPnAs0YLD0vdbC6bIeUFO1K
S7AW075XkmB04VYPZeUh6vBCBjoWXYClMyIzeEEVvAxOTEHMi3+nZn7jIel7uVMa
l0wEGhU+lY3MHfbHdmh2
=1k3b
-----END PGP SIGNATURE-----
