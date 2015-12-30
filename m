From: dcb314@hotmail.com (David Binderman)
Date: Wed, 30 Dec 2015 17:34:18 +0000
Subject: linux-4.4-rc7/arch/arm/common/icst.c: possible never ending loop ?
Message-ID: <DUB128-W73A2A10157A9D4E8D151FB9CFD0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.4-rc7/arch/arm/common/icst.c:61]: (style) Condition 'i<8' is always true

Source code is

??? do {
??????? f = freq * p->s2div[p->idx2s[i]];

??????? if (f> p->vco_min && f <= p->vco_max)
??????????? break;
??? } while (i < 8);

I see no place where i gets incremented.

Regards

David Binderman

 		 	   		  
