From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 4 Jan 2017 10:14:04 +0000
Subject: [PATCH v2 09/11] net: mvpp2: simplify MVPP2_PRS_RI_* definitions
In-Reply-To: <1482857660-16092-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482857660-16092-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482857660-16092-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02555FB@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni
> Sent: 27 December 2016 16:54
> Some of the MVPP2_PRS_RI_* definitions use the ~(value) syntax, which
> doesn't compile nicely on 64-bit. Moreover, those definitions are in
> fact unneeded, since they are always used in combination with a bit
> mask that ensures only the appropriate bits are modified.
> 
> Therefore, such definitions should just be set to 0x0. For example:
> 
>  #define MVPP2_PRS_RI_L2_CAST_MASK              0x600
>  #define MVPP2_PRS_RI_L2_UCAST                  ~(BIT(9) | BIT(10))
>  #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
>  #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)
> 
> becomes
> 
>  #define MVPP2_PRS_RI_L2_CAST_MASK              0x600
>  #define MVPP2_PRS_RI_L2_UCAST                  0x0
>  #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
>  #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)
...
Shouldn't MVPP2_PRS_RI_L2_CAST_MASK be defined as
(MVPP2_PRS_RI_L2_MCAST | MVPP2_PRS_RI_L2_BCAST)?

	David
