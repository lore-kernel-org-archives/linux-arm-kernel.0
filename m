From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Sep 2011 11:25:28 +0100
Subject: READ THIS: the next mach-types update
Message-ID: <20110915102528.GI6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm going to be merging a mach-types update (the cut-down and the
policy-conforming version) for the next merge window.  This will mean
that things WILL BREAK, and I will not notice that things have broken.

In order to fix this, entries need to be fixed to conform to the
requirements - where the machine_is_xxx() name is the same as the
MACH_TYPE_xxx name and the CONFIG_MACH_xxx name too.

Moreover, entries older than 12 months which have not been merged will
be removed.  It is not possible to automatically check for machine_is_xxx()
usages as these could conflict with other architectures, and I'm
certainly NOT checking for them by hand (I estimate that'd take a
significant amount of manual effort to do.)  What that means is that it
is _important_ to get the core platform support in _first_ before any
drivers which may make use of this.

The following will be deleted from the file this time around are:
-ts_x09                  MACH_TS209              TS209                   1565
-at572d940hfek           MACH_AT572D940HFEB      AT572D940HFEB           1783
-sheeva_esata            MACH_ESATA_SHEEVAPLUG   ESATA_SHEEVAPLUG        2678
-omap3_braillo           MACH_OMAP3_BRAILLO      OMAP3_BRAILLO           2839
-spyplug                 MACH_SPYPLUG            SPYPLUG                 2840
-ginger                  MACH_GINGER             GINGER                  2841
-tny_t3530               MACH_TNY_T3530          TNY_T3530               2842
-pca102                  MACH_PCA102             PCA102                  2843
-spade                   MACH_SPADE              SPADE                   2844
-mxc25_topaz             MACH_MXC25_TOPAZ        MXC25_TOPAZ             2845
-gw2361                  MACH_GW2361             GW2361                  2847
-elog                    MACH_ELOG               ELOG                    2848
-bcm589x                 MACH_BCM589X            BCM589X                 2850
-etna                    MACH_ETNA               ETNA                    2851
-hawks                   MACH_HAWKS              HAWKS                   2852
-meson                   MACH_MESON              MESON                   2853
-xsbase255               MACH_XSBASE255          XSBASE255               2854
-pvm2030                 MACH_PVM2030            PVM2030                 2855
-mioa502                 MACH_MIOA502            MIOA502                 2856
-htc_spv_m700            MACH_HTC_SPV_M700       HTC_SPV_M700            2860
-msm8x55_svlte_ffa       MACH_MSM8X55_SVLTE_FFA  MSM8X55_SVLTE_FFA       2863
-msm8x55_svlte_surf      MACH_MSM8X55_SVLTE_SURF MSM8X55_SVLTE_SURF      2864
-quickstep               MACH_QUICKSTEP          QUICKSTEP               2865
-dmw96                   MACH_DMW96              DMW96                   2866
-hammerhead              MACH_HAMMERHEAD         HAMMERHEAD              2867
-trident                 MACH_TRIDENT            TRIDENT                 2868
-lightning               MACH_LIGHTNING          LIGHTNING               2869
-iconnect                MACH_ICONNECT           ICONNECT                2870
-autobot                 MACH_AUTOBOT            AUTOBOT                 2871
-coconut                 MACH_COCONUT            COCONUT                 2872
-durian                  MACH_DURIAN             DURIAN                  2873
-cayenne                 MACH_CAYENNE            CAYENNE                 2874
-fuji                    MACH_FUJI               FUJI                    2875
-synology_6282           MACH_SYNOLOGY_6282      SYNOLOGY_6282           2876
-em1sy                   MACH_EM1SY              EM1SY                   2877
-m502                    MACH_M502               M502                    2878
-matrix518               MACH_MATRIX518          MATRIX518               2879
-tiny_gurnard            MACH_TINY_GURNARD       TINY_GURNARD            2880
-spear1310               MACH_SPEAR1310          SPEAR1310               2881
-mxt_td61                MACH_MXT_TD61           MXT_TD61                2883
-devixp                  MACH_DEVIXP             DEVIXP                  2885
-miccpt                  MACH_MICCPT             MICCPT                  2886
-mic256                  MACH_MIC256             MIC256                  2887
-as1167                  MACH_AS1167             AS1167                  2888
-omap3_ibiza             MACH_OMAP3_IBIZA        OMAP3_IBIZA             2889
-davinci_picto           MACH_DAVINCI_PICTO      DAVINCI_PICTO           2891
-mecha                   MACH_MECHA              MECHA                   2892
-bubba3                  MACH_BUBBA3             BUBBA3                  2893
-pupitre                 MACH_PUPITRE            PUPITRE                 2894
-tegra_vogue             MACH_TEGRA_VOGUE        TEGRA_VOGUE             2896
-tegra_e1165             MACH_TEGRA_E1165        TEGRA_E1165             2897
-simplenet               MACH_SIMPLENET          SIMPLENET               2898
-ec4350tbm               MACH_EC4350TBM          EC4350TBM               2899
-pec_tc                  MACH_PEC_TC             PEC_TC                  2900
-pec_hc2                 MACH_PEC_HC2            PEC_HC2                 2901
-esl_mobilis_a           MACH_ESL_MOBILIS_A      ESL_MOBILIS_A           2902
-esl_mobilis_b           MACH_ESL_MOBILIS_B      ESL_MOBILIS_B           2903
-esl_wave_a              MACH_ESL_WAVE_A         ESL_WAVE_A              2904
-esl_wave_b              MACH_ESL_WAVE_B         ESL_WAVE_B              2905
-unisense_mmm            MACH_UNISENSE_MMM       UNISENSE_MMM            2906
-blueshark               MACH_BLUESHARK          BLUESHARK               2907
-e10                     MACH_E10                E10                     2908
-app3k_robin             MACH_APP3K_ROBIN        APP3K_ROBIN             2909
-pov15hd                 MACH_POV15HD            POV15HD                 2910
-stella                  MACH_STELLA             STELLA                  2911
-netwalker               MACH_NETWALKER          NETWALKER               2914
-acsx106                 MACH_ACSX106            ACSX106                 2915
-atlas5_c1               MACH_ATLAS5_C1          ATLAS5_C1               2916
-nsb3ast                 MACH_NSB3AST            NSB3AST                 2917
-gnet_slc                MACH_GNET_SLC           GNET_SLC                2918
-af4000                  MACH_AF4000             AF4000                  2919
-ark9431                 MACH_ARK9431            ARK9431                 2920
-fs_s5pc100              MACH_FS_S5PC100         FS_S5PC100              2921
-omap3505nova8           MACH_OMAP3505NOVA8      OMAP3505NOVA8           2922
-omap3621_edp1           MACH_OMAP3621_EDP1      OMAP3621_EDP1           2923
-oratisaes               MACH_ORATISAES          ORATISAES               2924
-siemens_l0              MACH_SIEMENS_L0         SIEMENS_L0              2926
-ventana                 MACH_VENTANA            VENTANA                 2927
-ec4350sdb               MACH_EC4350SDB          EC4350SDB               2929
-mimas                   MACH_MIMAS              MIMAS                   2930
-titan                   MACH_TITAN              TITAN                   2931
-es2440                  MACH_ES2440             ES2440                  2933
-najay_a9263             MACH_NAJAY_A9263        NAJAY_A9263             2934
-htctornado              MACH_HTCTORNADO         HTCTORNADO              2935
-dimm_mx257              MACH_DIMM_MX257         DIMM_MX257              2936
-jigen301                MACH_JIGEN              JIGEN                   2937
-meno_qng                MACH_MENO_QNG           MENO_QNG                2939
-ns2416                  MACH_NS2416             NS2416                  2940
-rpc353                  MACH_RPC353             RPC353                  2941
-tq6410                  MACH_TQ6410             TQ6410                  2942
-sky6410                 MACH_SKY6410            SKY6410                 2943
-dynasty                 MACH_DYNASTY            DYNASTY                 2944
-vivo                    MACH_VIVO               VIVO                    2945
-bury_bl7582             MACH_BURY_BL7582        BURY_BL7582             2946
-bury_bps5270            MACH_BURY_BPS5270       BURY_BPS5270            2947
-basi                    MACH_BASI               BASI                    2948
-tn200                   MACH_TN200              TN200                   2949
-c2mmi                   MACH_C2MMI              C2MMI                   2950
-meson_6236m             MACH_MESON_6236M        MESON_6236M             2951
-meson_8626m             MACH_MESON_8626M        MESON_8626M             2952
-tube                    MACH_TUBE               TUBE                    2953
-messina                 MACH_MESSINA            MESSINA                 2954
-mx50_arm2               MACH_MX50_ARM2          MX50_ARM2               2955
-cetus9263               MACH_CETUS9263          CETUS9263               2956
-vmx25                   MACH_VMX25              VMX25                   2958
-vmx51                   MACH_VMX51              VMX51                   2959
-abacus                  MACH_ABACUS             ABACUS                  2960
-cm4745                  MACH_CM4745             CM4745                  2961
-oratislink              MACH_ORATISLINK         ORATISLINK              2962
-davinci_dm365_dvr       MACH_DAVINCI_DM365_DVR  DAVINCI_DM365_DVR       2963
-netviz                  MACH_NETVIZ             NETVIZ                  2964
-wlan_computer           MACH_WLAN_COMPUTER      WLAN_COMPUTER           2966
-lpc24xx                 MACH_LPC24XX            LPC24XX                 2967
-spica                   MACH_SPICA              SPICA                   2968
-gpsdisplay              MACH_GPSDISPLAY         GPSDISPLAY              2969
-bipnet                  MACH_BIPNET             BIPNET                  2970
-overo_ctu_inertial      MACH_OVERO_CTU_INERTIAL OVERO_CTU_INERTIAL      2971
-davinci_dm355_mmm       MACH_DAVINCI_DM355_MMM  DAVINCI_DM355_MMM       2972
-pc9260_v2               MACH_PC9260_V2          PC9260_V2               2973
-ptx7545                 MACH_PTX7545            PTX7545                 2974
-tm_efdc                 MACH_TM_EFDC            TM_EFDC                 2975
-omap3_waldo1            MACH_OMAP3_WALDO1       OMAP3_WALDO1            2977
-flyer                   MACH_FLYER              FLYER                   2978
-tornado3240             MACH_TORNADO3240        TORNADO3240             2979
-soli_01                 MACH_SOLI_01            SOLI_01                 2980
-omapl138_europalc       MACH_OMAPL138_EUROPALC  OMAPL138_EUROPALC       2981
-helios_v1               MACH_HELIOS_V1          HELIOS_V1               2982
-netspace_lite_v2        MACH_NETSPACE_LITE_V2   NETSPACE_LITE_V2        2983
-ssc                     MACH_SSC                SSC                     2984
-premierwave_en          MACH_PREMIERWAVE_EN     PREMIERWAVE_EN          2985
-wasabi                  MACH_WASABI             WASABI                  2986
-spx_sakura              MACH_SPX_SAKURA         SPX_SAKURA              2991
-ij3k_2440               MACH_IJ3K_2440          IJ3K_2440               2992
-omap3_bc10              MACH_OMAP3_BC10         OMAP3_BC10              2993
-thebe                   MACH_THEBE              THEBE                   2994
-rv082                   MACH_RV082              RV082                   2995
-armlguest               MACH_ARMLGUEST          ARMLGUEST               2996
-tjinc1000               MACH_TJINC1000          TJINC1000               2997
-ax8008                  MACH_AX8008             AX8008                  2999
-gnet_sgce               MACH_GNET_SGCE          GNET_SGCE               3000
-pxwnas_500_1000         MACH_PXWNAS_500_1000    PXWNAS_500_1000         3001
-ea20                    MACH_EA20               EA20                    3002
-awm2                    MACH_AWM2               AWM2                    3003
-ti8148evm               MACH_TI8148EVM          TI8148EVM               3004
-linkstation_chlv2       MACH_LINKSTATION_CHLV2  LINKSTATION_CHLV2       3006
-tera_pro2_rack          MACH_TERA_PRO2_RACK     TERA_PRO2_RACK          3007
-rubys                   MACH_RUBYS              RUBYS                   3008
-aquarius                MACH_AQUARIUS           AQUARIUS                3009
-lswxl                   MACH_LSWXL              LSWXL                   3012
-dove_avng_v3            MACH_DOVE_AVNG_V3       DOVE_AVNG_V3            3013
-sdi_ess_9263            MACH_SDI_ESS_9263       SDI_ESS_9263            3014
-jocpu550                MACH_JOCPU550           JOCPU550                3015
-yanomami                MACH_YANOMAMI           YANOMAMI                3018
-gta04                   MACH_GTA04              GTA04                   3019
-omap3_rfs200            MACH_OMAP3_RFS200       OMAP3_RFS200            3021
-kx33xx                  MACH_KX33XX             KX33XX                  3022
-ptx7510                 MACH_PTX7510            PTX7510                 3023
-top9000                 MACH_TOP9000            TOP9000                 3024
-teenote                 MACH_TEENOTE            TEENOTE                 3025
-ts3                     MACH_TS3                TS3                     3026
-a0                      MACH_A0                 A0                      3027
-fsm9xxx_surf            MACH_FSM9XXX_SURF       FSM9XXX_SURF            3028
-fsm9xxx_ffa             MACH_FSM9XXX_FFA        FSM9XXX_FFA             3029
-frrhwcdma60w            MACH_FRRHWCDMA60W       FRRHWCDMA60W            3030
-remus                   MACH_REMUS              REMUS                   3031
-at91cap7xdk             MACH_AT91CAP7XDK        AT91CAP7XDK             3032
-at91cap7stk             MACH_AT91CAP7STK        AT91CAP7STK             3033
-kt_sbc_sam9_1           MACH_KT_SBC_SAM9_1      KT_SBC_SAM9_1           3034
-armada_xp_db            MACH_ARMADA_XP_DB       ARMADA_XP_DB            3036
-spdm                    MACH_SPDM               SPDM                    3037
-gtib                    MACH_GTIB               GTIB                    3038
-dgm3240                 MACH_DGM3240            DGM3240                 3039
-htcmega                 MACH_HTCMEGA            HTCMEGA                 3041
-tricorder               MACH_TRICORDER          TRICORDER               3042
-bstbrd                  MACH_BSTBRD             BSTBRD                  3044
-pwb3090                 MACH_PWB3090            PWB3090                 3045
-idea6410                MACH_IDEA6410           IDEA6410                3046
-qbc9263                 MACH_QBC9263            QBC9263                 3047
-borabora                MACH_BORABORA           BORABORA                3048
-valdez                  MACH_VALDEZ             VALDEZ                  3049
-ls9g20                  MACH_LS9G20             LS9G20                  3050
-mios_v1                 MACH_MIOS_V1            MIOS_V1                 3051
-s5pc110_crespo          MACH_S5PC110_CRESPO     S5PC110_CRESPO          3052
-controltek9g20          MACH_CONTROLTEK9G20     CONTROLTEK9G20          3053
-tin307                  MACH_TIN307             TIN307                  3054
-tin510                  MACH_TIN510             TIN510                  3055
-bluecheese              MACH_BLUECHEESE         BLUECHEESE              3057
-tem3x30                 MACH_TEM3X30            TEM3X30                 3058
-harvest_desoto          MACH_HARVEST_DESOTO     HARVEST_DESOTO          3059
-msm8x60_qrdc            MACH_MSM8X60_QRDC       MSM8X60_QRDC            3060
-spear900                MACH_SPEAR900           SPEAR900                3061
-rdstor                  MACH_RDSTOR             RDSTOR                  3063
-usdloader               MACH_USDLOADER          USDLOADER               3064
-tsoploader              MACH_TSOPLOADER         TSOPLOADER              3065
-kronos                  MACH_KRONOS             KRONOS                  3066
-ffcore                  MACH_FFCORE             FFCORE                  3067
-mone                    MACH_MONE               MONE                    3068
-unit2s                  MACH_UNIT2S             UNIT2S                  3069
-acer_a5                 MACH_ACER_A5            ACER_A5                 3070
-etherpro_isp            MACH_ETHERPRO_ISP       ETHERPRO_ISP            3071
-stretchs7000            MACH_STRETCHS7000       STRETCHS7000            3072
-p87_smartsim            MACH_P87_SMARTSIM       P87_SMARTSIM            3073
-tulip                   MACH_TULIP              TULIP                   3074
-sunflower               MACH_SUNFLOWER          SUNFLOWER               3075
-rib                     MACH_RIB                RIB                     3076
-clod                    MACH_CLOD               CLOD                    3077
-rump                    MACH_RUMP               RUMP                    3078
-tenderloin              MACH_TENDERLOIN         TENDERLOIN              3079
-shortloin               MACH_SHORTLOIN          SHORTLOIN               3080
-sc575hmi                MACH_SC575IPC           SC575IPC                3191
-dma_6410                MACH_DMA6410            DMA6410                 3316
-pgs_v1                  MACH_PGS_SITARA         PGS_SITARA              3322
-sdh001                  MACH_MACH_SDH001        MACH_SDH001             3390
-msm8960_mdp             MACH_MSM8960_MDP        MSM8960_MDP             3397

That's 214 entries being removed (and no, I'm NOT going to look up who
to contact about each one.)

The following will be deleted from the machine database:

 tegra                   MACH_TEGRA              TEGRA                   3738

as it doesn't conform to the policy of this being a _platform_ database
not a _soc_ database.
