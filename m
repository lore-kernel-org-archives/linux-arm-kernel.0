From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Fri,  2 Apr 2010 17:36:01 +0300
Subject: [RFC PATCH v5 0/2] ARM: VFP: Save / restore VFP state on the signal
	handler path
In-Reply-To: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
Message-ID: <cover.1270199787.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

Changes since v4:
- Do not add the packed attribute to user_vfp or user_vfp_exc.
  I added packed to these structs to prevent the extra padding in
  vfp_sigframe. But actually the padding is in accordance with the
  ARM ABI. Also removing the padding from user_vfp would break
  the ptrace interface.

--Imre
