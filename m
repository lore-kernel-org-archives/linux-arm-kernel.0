From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 21 Nov 2014 14:25:45 +0100
Subject: thermal: Exynos: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <alpine.DEB.2.10.1411211116580.2554@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <546F1017.5080403@users.sourceforge.net>
 <alpine.DEB.2.10.1411211116580.2554@hadrien>
Message-ID: <546F3D59.2060504@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>  	for (i = 0; i < th_zone->cool_dev_size; i++) {
>> -		if (th_zone->cool_dev[i])
>> -			cpufreq_cooling_unregister(th_zone->cool_dev[i]);
>> +		cpufreq_cooling_unregister(th_zone->cool_dev[i]);
>>  	}
> 
> Now you have unnecessary {}

How are the chances that your source code transformation tool
can also consider the deletion of curly brackets in such an use case?

Can any more pretty-printing rules be integrated from a specific
coding style configuration?

Regards,
Markus
