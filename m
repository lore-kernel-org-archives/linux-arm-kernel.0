From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 12 Apr 2014 18:37:54 +0200
Subject: [REGRESSION, BISECTED] mvneta broken in 3.14 on RN2120,
 RN102 and RN104 after e3a8786c10e7
In-Reply-To: <20140412183112.7ca31cb6@skate> (Thomas Petazzoni's message of
 "Sat, 12 Apr 2014 18:31:12 +0200")
References: <87k3au8qba.fsf@natisbad.org> <20140412183112.7ca31cb6@skate>
Message-ID: <87vbueo659.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

>> I built a first kernel with the 'else' branch above removed (rationale:
>> SERDES config was not set for RGMII prior to the patch). The issue
>> remained.
>>      
>>     -       mvneta_gmac_rgmii_set(pp, 1);
>>     +       val = mvreg_read(pp, MVNETA_GMAC_CTRL_2);
>>     +
>>     +       val |= MVNETA_GMAC2_PCS_ENABLE | MVNETA_GMAC2_PORT_RGMII;
>> 
>> I removed MVNETA_GMAC2_PCS_ENABLE flag setting (rationale: it was only
>> done for SGMII prior to the patch and all my platforms have RGMII
>> connected PHY). *The issue disappeared on all 3 NAS with that simple
>> change*.
>
> Yes, issue known. See https://bugzilla.kernel.org/show_bug.cgi?id=73401.
>
> Unfortunately, at this point I don't have enough informations to fix
> both issues: the issue you're having, and the issue of using mvneta as
> a module. Since the issue you're having is much more problematic, I'll
> send a patch to revert my patch, until I have enough informations to
> fix the problem in a proper way.
>
> Thanks for your report!

Thanks for your work and the fast feedback. Do not hesitate to bug me if
you want me to do some tests at some point.

Cheers,

a+
