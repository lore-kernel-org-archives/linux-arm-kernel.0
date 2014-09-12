From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 12 Sep 2014 07:07:44 +0300
Subject: Q about driver code for KSZ8873MML
In-Reply-To: <CAH=J7GMQMGhEgiGQiXru1P4zdZjemFwwWrUjhRWBN+jS-qsF=Q@mail.gmail.com>
References: <CAH=J7GMQMGhEgiGQiXru1P4zdZjemFwwWrUjhRWBN+jS-qsF=Q@mail.gmail.com>
Message-ID: <20140912040744.GD2522@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Thu, Sep 11, 2014 at 10:40:29PM -0400, Patrick Boyle wrote:
> In the linux/include/micrel_phy.h file the PHY ID for the KSZ8873MML
> is defined as (0x000e7237)
> 
> #define MICREL_PHY_ID_MASK     0x00fffff0
> 
> #define PHY_ID_KSZ8873MLL      0x000e7237
> #define PHY_ID_KSZ9021         0x00221610
> #define PHY_ID_KSZ8737         0x00221720
> /* same id: KS8021, KS8031 */
> #define PHY_ID_KSZ8021         0x00221555
> #define PHY_ID_KSZ8041         0x00221510
> #define PHY_ID_KSZ8051         0x00221550
> /* same id: ks8001 Rev. A/B, and ks8721 Rev 3. */
> #define PHY_ID_KSZ8001         0x0022161A
> /* same id: KS8081, KS8091 */
> #define PHY_ID_KSZ8081         0x00221560
> #define PHY_ID_KSZ8061         0x00221570
> #define PHY_ID_KSZ9031         0x00221620
> 
> /* struct phy_device dev_flags definitions */
> #define MICREL_PHY_50MHZ_CLK   0x00000001
> 
> But the datasheet from Micrel for this part (and using mii to probe
> the part on my board) shows:
> 
> 0x00221430
> 
> So where did 0x000e7237 come from?

git has a wonderful tool called 'git blame'. This tool indicates that the

#define PHY_ID_KSZ8873MLL      0x000e7237

line comes from commit 93272e07d8539c 
(http://git.kernel.org/linus/93272e07d8539c) by Jean-Christophe 
PLAGNIOL-VILLARD (added to Cc).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
